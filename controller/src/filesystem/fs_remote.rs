use std::sync::Arc;
use dashmap::DashMap;
use log::warn;
use tokio::net::TcpStream;
use tokio::sync::{mpsc, oneshot};
use tokio::runtime;
use futures_util::stream::{SplitSink, SplitStream};
use futures_util::StreamExt;
use serde_json::Value;
use tokio_tungstenite::tungstenite::Message;
use tokio_tungstenite::WebSocketStream;
use crate::filesystem::answers::FsAnswer;
use crate::filesystem::errors::AnswerHandlerError;
use crate::filesystem::requests::FsRequest;

type AnswerQueues = Arc<DashMap<u64, oneshot::Sender<FsAnswer>>>;

struct FsRemote {
    send: mpsc::Sender<FsRequestWithChannel>,
}

impl FsRemote {
    fn new(stream: TcpStream) -> Self {
        let (send, recv) = mpsc::channel(50);
        let rt = runtime::Builder::new_current_thread().build().unwrap();

        let ws_stream = rt.block_on(
            tokio_tungstenite::accept_async(stream)
        ).expect("Handshake failed");

        let (tcp_sink, tcp_stream) = ws_stream.split();

        let answer_queues: AnswerQueues = Arc::new(DashMap::with_capacity(10));
        let mut up = FsUp { recv, tcp_sink, answer_queues: answer_queues.clone() };
        let mut down = FsDown { tcp_stream, answer_queues: answer_queues.clone() };

        rt.spawn(async move { up.process_up().await; });
        rt.spawn(async move { down.process_down().await; });

        FsRemote { send }
    }

    pub fn request(&self, req: FsRequest) -> FsAnswer {
        let (answer_sender, answer_receiver) = oneshot::channel();

        self.send.blocking_send(FsRequestWithChannel { req, channel: answer_sender }).unwrap();

        answer_receiver.blocking_recv().expect("Answer receiver failed")
    }
}

#[derive(Debug)]
struct FsRequestWithChannel {
    req: FsRequest,
    channel: oneshot::Sender<FsAnswer>,
}

struct FsUp {
    recv: mpsc::Receiver<FsRequestWithChannel>,
    tcp_sink: SplitSink<WebSocketStream<TcpStream>, Message>,
    answer_queues: AnswerQueues,
}

impl FsUp {
    async fn process_up(&mut self) -> ! {
        loop {
            match self.recv.recv().await {
                Some(req) => {
                    self.answer_queues.insert(req.req.id(), req.channel);
                },
                None => {
                    warn!("fs_remote: recv returned None.");
                }
            }
        }
    }
}

struct FsDown {
    tcp_stream: SplitStream<WebSocketStream<TcpStream>>,
    answer_queues: AnswerQueues,
}

impl FsDown {
    async fn process_down(&mut self) -> ! {
        loop {
            match self.tcp_stream.next().await {
                Some(Ok(msg)) => {
                    match msg {
                        Message::Text(text) => {
                            let result = self.handle_answer(text);

                            if let Err(e) = result {
                                warn!("fs_remote: handle_answer failed: {}", e);
                            }
                        },
                        _ => {
                            warn!("fs_remote: unexpected message type.");
                        }
                    }
                },
                Some(Err(e)) => {
                    warn!("fs_remote: stream_read returned error: {}", e);
                },
                None => {
                    warn!("fs_remote: stream_read returned None.");
                }
            }
        }
    }

    fn handle_answer(&mut self, text: String) -> Result<(), AnswerHandlerError> {
        let answer: Value = serde_json::from_str(&text)?;
        let id = answer
            .get("id")
            .ok_or(AnswerHandlerError::new("frame doesn't contain an id key".to_string()))?
            .as_u64()
            .ok_or(AnswerHandlerError::new("id key is not a number".to_string()))?;

        let (_, answer_sender) = self.answer_queues
            .remove(&id)
            .ok_or(AnswerHandlerError::new("unknown id".to_string()))?;
        answer_sender.send(FsAnswer {})
            .or_else(|_| {
                Err(AnswerHandlerError::new("answer sender failed".to_string()))
            })?;

        Ok(())
    }
}

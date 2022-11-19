use tokio::task::JoinHandle;
use warp::Filter;

pub struct App {}

impl App {
    pub fn new() -> App {
        App {}
    }

    fn create_routes(&self) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
        warp::path::end()
            .and(warp::get())
            .map(|| "Hello, world!")
    }

    pub fn run_server(&self, port: u16) -> JoinHandle<()> {
        let routes = self.create_routes();
        let server = warp::serve(routes);
        let server = server.run(([0, 0, 0, 0], port));
        tokio::spawn(server)
    }
}
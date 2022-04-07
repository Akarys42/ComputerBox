pub struct AnswerHandlerError {
    pub message: String,
}

impl AnswerHandlerError {
    pub fn new(message: String) -> Self {
        AnswerHandlerError { message }
    }
}

impl std::fmt::Display for AnswerHandlerError {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "{}", self.message)
    }
}

impl From<serde_json::Error> for AnswerHandlerError {
    fn from(err: serde_json::Error) -> Self {
        AnswerHandlerError {
            message: err.to_string(),
        }
    }
}
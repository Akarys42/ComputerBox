use std::collections::HashMap;
use std::env;
use exec::execvp;
use log::{LevelFilter, info, warn, error};

mod filesystem;
mod selftest;
mod logging;
mod app;

fn shutdown() -> ! {
    let err = execvp("/bin/busybox", &["poweroff", "-f"]);
    error!("execvp poweroff failed: {}", err);
    panic!("Shutdown failed");
}

#[tokio::main]
async fn main() {
    println!("ComputerBox VM");
    logging::init_logging(LevelFilter::Info).expect("Failed to set up logging");

    let args: Vec<String> = env::args().collect();
    let parameters: HashMap<&str, &str> = args.iter().skip(1).map(|arg| {
        let mut parts = arg.splitn(2, '=');
        (parts.next().unwrap(), parts.next().unwrap_or(""))
    }).collect();

    match selftest::perform_selftest() {
        Ok(_) => info!("selftest: ok"),
        Err(error) => warn!("selftest: {}", error.message),
    }

    if parameters.get("selftest_only") == Some(&"true") {
        shutdown();
    }

    let app = app::App::new();
    let handle = app.run_server(9456);

    handle.await.expect("Server panicked");

    error!("Handle returned");
    shutdown();
}

use std::collections::HashMap;
use std::env;
use exec::execvp;
use log::{LevelFilter, info, warn, error};

mod selftest;
mod logging;

fn shutdown() -> ! {
    let err = execvp("/bin/busybox", &["poweroff", "-f"]);
    error!("execvp poweroff failed: {}", err);
    panic!("Shutdown failed");
}

fn main() {
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

    if parameters.get("selftests_only") == Some(&"true") {
        shutdown();
    }

    error!("Not implemented");
    shutdown();
}

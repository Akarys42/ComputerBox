use std::collections::HashMap;
use std::env;
use exec::execvp;

mod selftest;

fn shutdown() -> ! {
    let err = execvp("/bin/busybox", &["poweroff", "-f"]);
    println!("execvp poweroff failed: {}", err);
    panic!("Shutdown failed");
}

fn main() {
    println!("ComputerBox VM");

    let args: Vec<String> = env::args().collect();
    let parameters: HashMap<&str, &str> = args.iter().skip(1).map(|arg| {
        let mut parts = arg.splitn(2, '=');
        (parts.next().unwrap(), parts.next().unwrap_or(""))
    }).collect();

    match selftest::perform_selftest() {
        Ok(_) => println!("selftest: ok"),
        Err(error) => println!("selftest: {}", error.message),
    }

    if parameters.get("selftests_only") == Some(&"true") {
        shutdown();
    }

    println!("Not implemented");
    shutdown();
}

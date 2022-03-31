use exec::execvp;

mod selftest;

fn main() {
    println!("ComputerBox VM");

    match selftest::perform_selftest() {
        Ok(_) => println!("selftest: ok"),
        Err(error) => println!("selftest: {}", error.message),
    }

    println!("Shutting down VM.");
    let err = execvp("/bin/busybox", &["poweroff", "-f"]);
    println!("Error: {}", err);
}

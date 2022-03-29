use exec::execvp;

mod selftest;

fn main() {
    println!("ComputerBox VM");

    let test_result = selftest::perform_selftest();
    match test_result {
        Ok(_) => println!("selftest: ok"),
        Err(error) => println!("selftest: {}", error.message),
    }

    println!("Shutting down VM.");
    let err = execvp("/bin/busybox", &["poweroff", "-f"]);
    println!("Error: {}", err);
}

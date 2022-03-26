use exec::execvp;

fn main() {
    println!("Hello, world!");

    println!("Shutting down VM.");
    let err = execvp("/bin/busybox", &["poweroff", "-f"]);
    println!("Error: {}", err);
}

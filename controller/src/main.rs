use std::path::Path;
use exec::execvp;
use fuse::Filesystem;

struct NullFS;

impl Filesystem for NullFS {}

fn main() {
    println!("Hello, world!");

    let p = Path::new("/test");
    fuse::mount(NullFS, &p, &[]).unwrap();

    println!("Shutting down VM.");
    let err = execvp("/bin/busybox", &["poweroff", "-f"]);
    println!("Error: {}", err);
}

fn main() {
    println!("cargo:rustc-link-arg=--sysroot=../image/sysroot");
    println!("cargo:rustc-link-search=native=../image/sysroot/usr/local/lib");
    println!("cargo:rustc-link-search=native=../image/sysroot/usr/lib");
    println!("cargo:rustc-link-search=native=../image/sysroot/lib")
}
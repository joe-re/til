use std::io;
fn main() {
    const MAX:i32 = 20000;
    let mut input = String::new();
    match io::stdin().read_line(&mut input) {
        Ok(_n) => {
          println!("{}", input);
        }
        Err(error) => println!("error: {}", error),
    }
    println!("Hello, world!");
}

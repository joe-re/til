fn main() {
    println!("Hello, world!");
    for_test();
    enumerate_test();
}

fn for_test() {
    for x in 0..10 {
        println!("{:?}", x);
    }
}

fn enumerate_test() {
    for (i, j) in (5..10).enumerate() {
        println!("i = {}, j = {}", i, j);
    }
}

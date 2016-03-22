fn main() {
    println!("Hello, world!");
    for_test();
    enumerate_test();
    break_test();
    continue_test();
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

fn break_test() {
    let mut x = 5;
    loop {
        x += x - 3;
        println!("{}", x);
        if x % 5 == 0 { break; }
    }
}

fn continue_test() {
    for x in 0..10 {
        if x % 2 == 0 { continue; }
        println!("{}", x);
    }
}

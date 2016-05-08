use std::io;
use std::cmp;

fn main() {
    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();
    let n = input.replace("\n", "").parse::<i32>().unwrap();
    let a: Vec<i32> = (0..n).map(|_x| {
        input = String::new();
        io::stdin().read_line(&mut input).unwrap();
        return input.replace("\n", "").parse::<i32>().unwrap();
    }).collect();
    let mut maxv = -20000;
    let mut minv = a[0];
    for i in 1..n {
        maxv = cmp::max(maxv, a[i as usize] - minv);
        minv = cmp::min(minv, a[i as usize]);
    }
    println!("{:?}", maxv);
}

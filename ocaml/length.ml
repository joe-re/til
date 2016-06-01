let rec length lst = match lst with
  [] -> 0
  | first::rest -> 1 + length rest
let test1 = length [] = 0
let test2 = length [1] = 1
let test3 = length [1; 2;] = 2
let test4 = length [1; 2; 3; 4;] = 4
let test5 = length [1; 2; 3; 4; 5; 6; 7] = 7

let rec even lst = match lst with
  [] -> lst
  | first::rest -> if first mod 2 = 0 then first::even rest
                                      else even rest
let test1 = even [2; 1; 6; 4; 7] = [2; 6; 4]
let test2 = even [1; 1; 55; 56; 100] = [56; 100]

let rec calc lst =
  match lst with
   [] -> 0
  | first::rest->
    let rec loop lst2 maxv minv =
      match lst2 with
        [] -> maxv
        | first :: rest -> (
          let next_maxv = max maxv (first - minv) in
          let next_minv = min first minv in
            loop rest next_maxv next_minv
          ) in
    loop rest 0 first


let test1 = calc [6;5;3;1;3;4;3]
let test2 = calc [3;4;3;2]
let () =
  print_int test1;
  print_newline();
  print_int test2;

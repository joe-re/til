let rec insert x lst =
  match lst with
  | [] -> [x]
  | first::rest ->
    if first > x then x::first::rest
    else first::insert x rest

let rec sort lst =
  match lst with
  | [] -> []
  | first::rest -> insert first (sort rest)

let test1 = sort [5;2;4;6;1;3]
let () =
  let rec print lst =
    match lst with
    | [] -> ()
    | first::rest -> print_int first; print rest
  in print test1

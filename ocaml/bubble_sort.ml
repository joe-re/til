let rec bubble = function
    h1 :: h2 :: t when h1 > h2 -> h2 :: bubble (h1 :: t)
  | h1 :: t -> h1 :: bubble t
  | [] -> [];;

let rec sort l =
  let l' = bubble l in
    if l <> l' then sort l'
               else l

let test1 = sort [5;2;4;6;1;3]
let () =
  let rec print lst =
    match lst with
    | [] -> ()
    | first::rest -> print_int first; print rest
  in print test1


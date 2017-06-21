let rec sort = function
    [] -> []
  | first::rest ->
    let rec select_lst small dist = function
      | first::rest when first < small
        -> select_lst first (small::dist) rest
      | first::rest
        -> select_lst small (first::dist) rest
      | [] -> small::(sort dist)
    in select_lst first [] rest

let test1 = sort [5;2;4;6;1;3]
let () =
  let rec print lst =
    match lst with
    | [] -> ()
    | first::rest -> print_int first; print rest
  in print test1


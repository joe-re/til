let rec fold_right f lst init = match lst with
  [] -> init
  | first :: rest -> f first (fold_right f rest init)

let sum lst =
  let add_int first rest_result = first + rest_result
  in fold_right add_int lst 0

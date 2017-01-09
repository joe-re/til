let compare_ign_case str ign = String.lowercase_ascii(str) = ign

type elem_t = {
  a: int;
  b: int;
}

let calc_top_element f lst = match lst with
  [] -> print_endline "empty list"; lst
  | first::second::rest -> f first second::rest
  | first::rest -> print_endline "lack of operand"; lst

let add_top_element lst =
  let f first rest_result = first + rest_result in
  calc_top_element f lst

let sub_top_element lst =
  let f first rest_result = first - rest_result in
  calc_top_element f lst

let ply_top_element lst =
  let f first rest_result = first * rest_result in
  calc_top_element f lst

let div_top_element lst =
  let f first rest_result = first / rest_result in
  calc_top_element f lst

let show_first_element lst = match lst with
  [] -> print_endline "empty list"
  | first::rest -> print_endline (string_of_int first)

let rec print_stack lst = match lst with
  [] -> None
  | first::rest -> print_endline (string_of_int first); print_stack rest


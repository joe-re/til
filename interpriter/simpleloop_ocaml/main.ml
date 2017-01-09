open Util;;

let stck = ref [] in
let quit_loop = ref false in
while not !quit_loop do
  print_string "->";
  let s = read_line () in
  if compare_ign_case s "quit" then
    quit_loop := true
  else if compare_ign_case s "printstack" then
    let tmp = print_stack !stck in
    print_endline "--- end stack ---"
  else
    print_endline s;
    match s with
    "+" ->
      stck := add_top_element !stck;
      show_first_element !stck
    | "-" ->
      stck := sub_top_element !stck;
      show_first_element !stck
    | "*" ->
      stck := ply_top_element !stck;
      show_first_element !stck
    | "/" ->
      stck := div_top_element !stck;
      show_first_element !stck
    | other ->
      stck :=  int_of_string s::!stck
done

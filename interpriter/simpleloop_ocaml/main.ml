open Util;;

let quit_loop = ref false in
while not !quit_loop do
  print_string "->";
  let str = read_line () in
  if compare_ign_case(str) then
    quit_loop := true
  else
    print_endline(str)
done

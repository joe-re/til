let comp_ign_case c1 c2 =
  String.lowercase_ascii c1 = String.lowercase_ascii c2

let print_stack lst =
  let rec loop lst = match lst with
    [] -> ()
    | first::rest -> print_endline(string_of_float first); loop rest in loop lst

let () =
  let stck = ref [] in
  let quit_loop = ref false in
  while not !quit_loop do
    print_string "->";
    let str = read_line () in
    if comp_ign_case "quit" str then
      quit_loop := true
    else if comp_ign_case "printstack" str then
      print_stack !stck
    else
      stck := float_of_string str::!stck
  done


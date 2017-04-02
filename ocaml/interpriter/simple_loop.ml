let comp_ign_case c1 c2 =
  String.lowercase_ascii c1 = String.lowercase_ascii c2

let () =
  let quit_loop = ref false in
  while not !quit_loop do
    print_string "->";
    let str = read_line () in
    if comp_ign_case "quit" str then
      quit_loop := true
    else
      print_endline str;
  done


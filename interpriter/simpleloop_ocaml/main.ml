let quit_loop = ref false in
while not !quit_loop do
  print_string "->";
  let str = read_line () in
  if String.lowercase_ascii(str) = "quit" then
    quit_loop := true
  else
    print_endline(str)
done

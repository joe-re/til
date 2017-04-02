let comp_ign_case c1 c2 =
  String.lowercase_ascii c1 = String.lowercase_ascii c2

let print_stack lst =
  let rec loop lst = match lst with
    [] -> ()
    | first::rest -> print_endline(string_of_float first); loop rest in loop lst

let get_top_2_elem lst = match lst with
  [] -> None
  | first::second::rest -> Some(first, second, rest)
  | first::rest -> None

let calc_top_2_elem f lst =
  let elems = get_top_2_elem lst in
  match elems with
  | Some(first, second, rest) ->
    print_endline(string_of_float(f(first, second)));
    f(first, second)::rest
  | None -> print_endline "lack of operand"; lst

let add_top_stack lst =
  let f(first, second) = first +. second in calc_top_2_elem f lst

let sub_top_stack lst =
  let f(first, second) = first -. second in calc_top_2_elem f lst

let div_top_stack lst =
  let f(first, second) = first /. second in calc_top_2_elem f lst

let mul_top_stack lst =
  let f(first, second) = first *. second in calc_top_2_elem f lst

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
      stck :=  match str.[0] with
        | '+' -> add_top_stack !stck
        | '-' ->
          if String.length str = 1 then sub_top_stack !stck
          else float_of_string str::!stck
        | '/' -> div_top_stack !stck
        | '*' -> mul_top_stack !stck
        | _ -> float_of_string str::!stck
  done


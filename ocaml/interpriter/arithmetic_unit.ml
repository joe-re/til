type tokenType = Start | Value | Plus | Minus | Mult | Divide | LParen | RParen
type token = { value : float option; tokenType : tokenType }

let getTokenTypeName token = match token with
  { value=v; tokenType=t } ->
    match t with
      Value -> (match v with None -> "" | Some v -> string_of_float v)
      | Start -> "start"
      | Plus -> "+"
      | Minus -> "-"
      | Divide -> "/"
      | Mult -> "*"
      | LParen -> "("
      | RParen -> ")"

let comp_ign_case c1 c2 =
  String.lowercase_ascii c1 = String.lowercase_ascii c2

let print_stack lst =
  let rec loop lst = match lst with
    [] -> ()
    | first::rest -> print_endline(getTokenTypeName first); loop rest in loop lst

let get_top_2_elem lst = match lst with
  [] -> None
  | first::second::rest -> Some(first, second, rest)
  | first::rest -> None

let get_top_elem lst = match lst with
  [] -> None
  | first::rest -> Some(first)

let get_value v = match v with
  | Some v -> v
  | None -> raise (Invalid_argument "Option.get")

let calc_top_2_elem f lst =
  let elems = get_top_2_elem lst in
  match elems with
  | Some(first, second, rest) -> (
      match first.tokenType, second.tokenType with
      | Value, Value ->
        let f_v, s_v = get_value(second.value), get_value(first.value) in
        let v = f(f_v, s_v) in
        let _ = print_endline(string_of_float v) in
          { value=Some(v); tokenType=Value }::rest
      | _ ->
        print_endline "lack of operand"; lst
    )
  | None -> print_endline "lack of operand"; lst

let add_top_stack lst =
  let f(first, second) = first +. second in calc_top_2_elem f lst

let sub_top_stack lst =
  let f(first, second) = first -. second in calc_top_2_elem f lst

let div_top_stack lst =
  let f(first, second) = first /. second in calc_top_2_elem f lst

let mul_top_stack lst =
  let f(first, second) = first *. second in calc_top_2_elem f lst

let is_number s =
  try ignore (float_of_string s); true
  with _ -> false

let calc stck new_token =
  let elms = get_top_2_elem stck in
  match elms with
    | Some(first, second, rest) -> (
        let new_list = [new_token; second] @ rest in
        match first.tokenType with
        | Plus   -> add_top_stack new_list
        | Minus  -> sub_top_stack new_list
        | Divide -> div_top_stack new_list
        | Mult   -> mul_top_stack new_list
        | _      -> stck
      )
    | None -> stck

let rec calcurate_stck stck str =
  let value_token = { value=Some(float_of_string str); tokenType=Value } in
  match stck with
  | [] -> value_token::stck
  | [_] -> value_token::stck
  | _ ->
    let elem = get_top_2_elem stck in
    match elem with
    | None -> stck
    | Some(f, _, _) when f.tokenType = LParen -> value_token::stck
    | Some(f, _, r) ->
      let tt = get_top_elem r in
      match tt with
        | Some(x) when x.tokenType = LParen -> value_token::stck
        | _ ->
          let next_stck = calc stck value_token in
          match next_stck with
            | first::rest when first.tokenType = Value -> let s = getTokenTypeName(first) in calcurate_stck rest s
            | _ -> next_stck


let process_RParen stck =
  let elems1 = get_top_2_elem stck in
  match elems1 with
  | Some(top, top_1, r1) -> (
    let elems2 = get_top_2_elem r1 in
    match elems2 with
    | Some(top_2, top_3, r2) -> (
      let next_stck = calc ([top_1; top_2] @ r2) top in
      match next_stck with
        | first::rest when first.tokenType = Value -> let s = getTokenTypeName(first) in calcurate_stck rest s
        | _ -> next_stck
      )
    | None -> stck
    )
  | None -> stck

exception SyntaxError

let () =
  let stck = ref [] in
  let prev_token = { value=None; tokenType=Start } in
  let quit_loop = ref false in
  while not !quit_loop do
    print_string "->";
    let str = read_line () in
    if comp_ign_case "quit" str then
      quit_loop := true
    else if comp_ign_case "printstack" str then
      print_stack !stck
    else if String.length(str) = 1 && is_number(str) = false then
      stck := match str.[0] with
        | '+' -> { value=None; tokenType=Plus }::!stck
        | '-' ->
          if String.length str = 1 then { value=None; tokenType=Minus }::!stck
          else { value=Some(float_of_string str); tokenType=Value }::!stck
        | '/' -> { value=None; tokenType=Divide }::!stck
        | '*' -> { value=None; tokenType=Mult }::!stck
        | '(' -> { value=None; tokenType=LParen }::!stck
        | ')' -> process_RParen !stck
        | _   -> print_endline "syntax error"; !stck
    else
      stck := calcurate_stck !stck str
  done


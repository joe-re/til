let yen_of_dollar x = int_of_float (x *. 114.32)
let dollar_of_yen x  = let yen = float_of_int(x) in yen /. 114.32
let create_str dollar =
  string_of_float(dollar) ^ " dollars are " ^ string_of_int(yen_of_dollar(dollar)) ^ " yen."

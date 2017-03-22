let pow x n =
  let rec loop x n res =
    if n = 0 then res
    else loop x (n - 1) (x *. res)
  in loop x n 1.0

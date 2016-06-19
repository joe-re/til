let rec filter_positive lst = match lst with
  [] -> []
  | first :: rest ->
      if first > 0 then first :: filter_positive rest
                   else filter_positive rest

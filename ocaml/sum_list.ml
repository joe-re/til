let rec sum_list = function
    [] -> 0
  | n :: rest -> n + (sum_list rest);;

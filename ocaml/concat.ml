let rec concat lst = match lst with
  [] -> ""
  | first::rest -> first ^ concat rest
let test1 = concat ["春"; "夏"; "秋"; "冬"] = "春夏秋冬"




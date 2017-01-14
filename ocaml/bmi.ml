let bmi (name, height, weight) =
  let bmi = weight /. height ** 2.0 in
  if bmi < 18.5 then name ^ "さんは痩せています"
  else if bmi >= 18.5 && bmi < 25.0 then name ^ "さんは標準です"
  else if bmi >= 25.0 && bmi < 30.0 then name ^ "さんは肥満です"
  else name ^ "さんは高度肥満です"

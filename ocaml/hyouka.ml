type gakusei_t = {
  namae: string;
  tensuu: int;
  seiseki: string;
}

let hyouka gakusei = match gakusei with
  { namae = n; tensuu = t; seiseki = s } ->
    { namae = n;
      tensuu = t;
      seiseki =
        if t >= 80 then "A"
        else if t >= 70 then "B"
        else if t >= 60 then "C"
        else "D"
    }

(* テスト *)
let test1 = hyouka { namae="test1"; tensuu=90; seiseki=""}
                 = { namae="test1"; tensuu=90; seiseki="A" }
let test2 = hyouka { namae="test2"; tensuu=80; seiseki=""}
                 = { namae="test2"; tensuu=80; seiseki="A" }
let test3 = hyouka { namae="test3"; tensuu=75; seiseki=""}
                 = { namae="test3"; tensuu=75; seiseki="B" }
let test4 = hyouka { namae="test4"; tensuu=60; seiseki=""}
                 = { namae="test4"; tensuu=60; seiseki="C" }
let test5 = hyouka { namae="test5"; tensuu=50; seiseki=""}
                 = { namae="test5"; tensuu=50; seiseki="D" }

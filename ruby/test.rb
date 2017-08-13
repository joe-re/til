p(1 + 2)
p(6 * 7)
p(40 + 2)
x = 1
p(2+x)

if 0 == 0
  p 42
else
  p 43
end

i = 0
while i < 10
  p(i)
  i = i + 1
end

case p(42)
when 0
  p(0)
when 1
  p(1)
else
  p("others")
end

p 1, 2, 3

ary = [1,2,3]
p ary[0]
p ary[1]
p ary[2]

hash = { 'foo' => 'foo_str', 'bar' => 'bar_str' }
p hash['foo']
p hash['bar']

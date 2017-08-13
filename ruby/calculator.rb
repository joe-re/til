require 'minruby'

def evaluate(tree)
  return tree[1] if tree[0] == 'lit'
  left = evaluate tree[1]
  right = evaluate tree[2]
  case tree[0]
  when '+' then left + right
  when '-' then left - right
  when '*' then left * right
  when '/' then left / right
  when '**' then left**right
  when '%' then left % right
  when '>' then left > right
  when '<' then left < right
  when '==' then left == right
  end
end

p evaluate(minruby_parse('2%4'))
p evaluate(minruby_parse('1 + 1 == 2'))
p evaluate(minruby_parse('1 + 1 < 2'))
p evaluate(minruby_parse('1 + 1 < 3'))

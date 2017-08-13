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

def max(tree, max_num = 0)
  if tree[0] == 'lit'
    return tree[1] > max_num ? tree[1] : max_num
  end
  left = max(tree[1], max_num)
  max(tree[2], left)
end

p evaluate(minruby_parse('2%4'))
p evaluate(minruby_parse('1 + 1 == 2'))
p evaluate(minruby_parse('1 + 1 < 2'))
p evaluate(minruby_parse('1 + 1 < 3'))
p max(minruby_parse('1 + 2 * 3'))
p max(minruby_parse('1 + 4 + 3'))

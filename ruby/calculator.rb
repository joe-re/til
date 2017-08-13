require 'minruby'

def sum(tree)
  return tree[1] if tree[0] == 'lit'
  left = sum(tree[1])
  right = sum(tree[2])
  left + right
end

tree = minruby_parse('1 + 2 + 3 + 4')
p sum(tree)

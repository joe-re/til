require 'minruby'

def evaluate(tree, env = {})
  return tree[1] if tree[0] == 'lit'
  case tree[0]
  when '+' then evaluate(tree[1], env) + evaluate(tree[2], env)
  when '-' then evaluate(tree[1], env) - evaluate(tree[2], env)
  when '*' then evaluate(tree[1], env) * evaluate(tree[2], env)
  when '/' then evaluate(tree[1], env) / evaluate(tree[2], env)
  when '%' then evaluate(tree[1], env) % evaluate(tree[2], env)
  when '>' then evaluate(tree[1], env) > evaluate(tree[2], env)
  when '<' then evaluate(tree[1], env) < evaluate(tree[2], env)
  when '==' then evaluate(tree[1], env) == evaluate(tree[2], env)
  when '**' then evaluate(tree[1], env) ** evaluate(tree[2], env)
  when 'func_call' then p evaluate(tree[2], env)
  when 'var_assign'
    env[tree[1]] = evaluate(tree[2], env)
  when 'var_ref'
    env[tree[1]]
  when 'if'
    return evaluate(tree[2], env) if evaluate(tree[1], env)
    evaluate(tree[3], env)
  when 'while'
    while evaluate(tree[1], env)
      evaluate(tree[2], env)
    end
  when 'stmts'
    i = 1
    last = nil
    while tree[i] != nil
      last = evaluate(tree[i], env)
      i += 1
    end
    last
  end
end

def max(tree, max_num = 0)
  if tree[0] == 'lit'
    return tree[1] > max_num ? tree[1] : max_num
  end
  left = max(tree[1], max_num)
  max(tree[2], left)
end

# p evaluate(minruby_parse('2%4'))
# p evaluate(minruby_parse('1 + 1 == 2'))
# p evaluate(minruby_parse('1 + 1 < 2'))
# p evaluate(minruby_parse('1 + 1 < 3'))
# p max(minruby_parse('1 + 2 * 3'))
# p max(minruby_parse('1 + 4 + 3'))

str = minruby_load()
tree = minruby_parse(str)
evaluate(tree)

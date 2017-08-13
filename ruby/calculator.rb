require 'minruby'

init_genv = {
  'p' => ['builtin', 'p']
}

def evaluate(tree, genv = {}, lenv = {})
  return tree[1] if tree[0] == 'lit'
  case tree[0]
  when '+' then evaluate(tree[1], genv, lenv) + evaluate(tree[2], genv, lenv)
  when '-' then evaluate(tree[1], genv, lenv) - evaluate(tree[2], genv, lenv)
  when '*' then evaluate(tree[1], genv, lenv) * evaluate(tree[2], genv, lenv)
  when '/' then evaluate(tree[1], genv, lenv) / evaluate(tree[2], genv, lenv)
  when '%' then evaluate(tree[1], genv, lenv) % evaluate(tree[2], genv, lenv)
  when '>' then evaluate(tree[1], genv, lenv) > evaluate(tree[2], genv, lenv)
  when '<' then evaluate(tree[1], genv, lenv) < evaluate(tree[2], genv, lenv)
  when '==' then evaluate(tree[1], genv, lenv) == evaluate(tree[2], genv, lenv)
  when '**' then evaluate(tree[1], genv, lenv) ** evaluate(tree[2], genv, lenv)
  when 'func_call'
    args = []
    i = 0
    while tree[i + 2]
      args[i] = evaluate(tree[i + 2], genv, lenv)
      i += 1
    end
    mhd = genv[tree[1]]
    if mhd[0] == 'builtin'
      minruby_call(mhd[1], args)
    else
      new_env ={}
      params = mhd[1]
      i = 0
      while params[i]
        new_env[params[i]] = args[i]
        i += 1
      end
      evaluate(mhd[2], genv, new_env)
    end
  when 'func_def'
    genv[tree[1]] = ['user_defined', tree[2], tree[3]]
  when 'var_assign'
    lenv[tree[1]] = evaluate(tree[2], genv, lenv)
  when 'var_ref'
    lenv[tree[1]]
  when 'if'
    return evaluate(tree[2], genv, lenv) if evaluate(tree[1], genv, lenv)
    evaluate(tree[3], genv, lenv)
  when 'while'
    while evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    end
  when 'stmts'
    i = 1
    last = nil
    while tree[i] != nil
      last = evaluate(tree[i], genv, lenv)
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
evaluate(tree, init_genv)

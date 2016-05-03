op = ['*', '']
(1000..10000).each do |i|
  c = i.to_s
  op.each do |op1|
    op.each do |op2|
      op.each do |op3|
        val = (c[3] + op1 + c[2] + op2 + c[1] + op3 + c[0]).gsub(/0+(\d+)/) { $1 }
        puts "#{val}: #{eval val}" if val.length > 4 && i == eval(val)
      end
    end
  end
end

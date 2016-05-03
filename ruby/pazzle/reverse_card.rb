cards = (1..100).map { false }
(2..100).each do |i|
  j = i - 1
  while j < 100
    cards[j] = !cards[j]
    j += i
  end
end
puts (cards.map.with_index { |v, i| v ? nil : i + 1 }).compact

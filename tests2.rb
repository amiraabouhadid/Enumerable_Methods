require_relative 'enums'
puts '1.--------my_each--------'
%w[Sharon Leo Leila Brian Arun].my_each { |friend| puts friend }
puts '2.--------my_each_with_index--------'
p %w[Sharon Leo Leila Brian Arun].my_each_with_index { |friend, index| puts friend if index.even? }
puts '3.--------my_select--------'
p arr = (%w[Sharon Leo Leila Brian Arun].my_select { |friend| friend != 'Brian' })

puts '4.--------my_all--------'
p(%w[ant bear cat].my_all? { |word| word.length >= 3 }) #=> true
p(%w[ant bear cat].my_all? { |word| word.length >= 4 }) #=> false
p %w[ant bear cat].my_all?(/t/) #=> false
p [1, 2i, 3.14].my_all?(Numeric) #=> true
p [].my_all? #=> true
p [3, 3, 3].my_all?(3) #=> true
p [0, 1, 2, 3, 4, 5, 6, 7].my_all?(3) #=> false
puts '5.--------my_any--------'
p(%w[ant bear cat].my_any? { |word| word.length >= 3 }) #=> true
p(%w[ant bear cat].my_any? { |word| word.length >= 4 }) #=> true
p %w[ant bear cat].my_any?(/d/) #=> false
p [nil, true, 99].my_any?(Integer) #=> true/
p [nil, true, 99].my_any? #=> true/
p [].my_any? #=> false
p [1, 2, false].my_any? #=> true
p %w[cat door rod blade].my_any?('cat') #=> true
puts '6.--------my_none--------'
p(%w[ant bear cat].my_none? { |word| word.length == 5 }) #=> true
p(%w[ant bear cat].my_none? { |word| word.length >= 4 }) #=> false
p %w[ant bear cat].my_none?(/d/) #=> true
p [1, 3.14, 42].my_none?(Float) #=> false
p [].my_none? #=> true
p [nil].my_none? #=> true
p [nil, false].my_none? #=> true
p [nil, false, true].my_none? #=> false
p %w[dog door rod blade].my_none?(5) #=> true
p [5, 'door', 'rod', 'blade'].my_none?(5) #=> false
puts '7.--------my_count--------'
arr = [1, 2, 4, 2]
p arr.my_count #=> 4
p arr.my_count(2) #=> 2
p(arr.my_count { |x| (x % 2).zero? }) #=> 3
puts '8.--------my_maps--------'
my_order = ['medium Big Mac', 'medium fries', 'medium milkshake']
p(my_order.my_map { |item| item.gsub('medium', 'extra large') })
p((0..5).my_map { |i| i * i })
puts 'my_map_proc'
my_proc = proc { |i| i * i }
p(1..5).my_map(my_proc) { |i| i + i }
puts '8.--------my_inject--------'
p((1..5).my_inject { |sum, n| sum + n }) #=> 15
p(1..5).my_inject(1) { |product, n| product * n } #=> 120
longest = %w[ant bear cat].my_inject do |memo, word|
  memo.length > word.length ? memo : word
end
puts longest #=> "bear"
puts 'multiply_els'
puts multiply_els([2, 4, 5]) #=> 40

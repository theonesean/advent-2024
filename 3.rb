input = File.read('input/3.txt')

# Part 1

mult_match = /mul\((?<lhs>[0-9]+),(?<rhs>[0-9]+)\)/

matches = input.scan(mult_match)

sum = 0

matches.each do |match|
  lhs = match[0].to_i
  rhs = match[1].to_i
  sum += lhs * rhs
end

puts "Part 1 solution"
puts sum

# Part 2

# only run multiplication if it's preceded by a "do()", ignore all muls after "don't()"

do_match = /do\(\)/
dont_match = /don't\(\)/

do_matches = [0]
input.scan(do_match) do |m|
  do_matches << $~.offset(0)[0]
end

dont_matches = []
input.scan(dont_match) do |m|
  dont_matches << $~.offset(0)[0]
end

mult_matches = []
input.scan(mult_match) do |m|
  mult_matches << [m, $~.offset(0)[0]]
end

new_sum = 0

mult_matches.each do |match|
  # which is most recent do() before this mul()?
  # which is most recent don't() before this mul()?
  # if do() is more recent than don't(), then multiply
  
  mul_idx = match[1]
  do_idx = do_matches.select { |idx| idx < mul_idx }.max
  dont_idx = dont_matches.select { |idx| idx < mul_idx }.max
  
  if do_idx && (!dont_idx || do_idx > dont_idx)
    lhs = match[0][0].to_i
    rhs = match[0][1].to_i
    new_sum += lhs * rhs
  end
end

puts "Part 2 solution"
puts new_sum
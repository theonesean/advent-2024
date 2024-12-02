# read in list
infile = File.read('input/1.txt')

first = []
second = []

infile.each_line do |line|
  split = line.split('   ')
  first << split[0].to_i
  second << split[1].to_i
end

first.sort!
second.sort!

# Part 1

difference = 0

first.each_with_index do |f, i|
  difference += (f - second[i]).abs
end

puts "Part 1 solution"
puts difference

# Part 2

freq = {}

second.each do |s|
  if freq[s]
    freq[s] += 1
  else
    freq[s] = 1
  end
end

similarity = 0

first.each do |f|
  if freq[f]
    similarity += f * freq[f]
  end
end

puts "Part 2 solution"
puts similarity
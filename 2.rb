# read file
infile = File.read('input/2.txt')

safe = []
unsafe = []

def is_safe(report)
  is_decreasing = report[1].to_i < report[0].to_i
  is_valid = true

  report.each_with_index do |r, i|
    if i == 0
      next
    end

    diff = r.to_i - report[i - 1].to_i
  
    # ensure decreasing/increasing throughout, and between 1 and 3
    if is_decreasing
      if -diff > 3 || -diff < 1
        is_valid = false
        break
      end
    else
      if diff > 3 || diff < 1
        is_valid = false
        break
      end
    end
  end
  return is_valid
end

infile.each_line do |line|
  report = line.split(' ')
  if is_safe(report)
    safe << line
  else
    unsafe << line
  end
end

puts "Part 1 solution"
puts safe.length

# Part 2

new_safe = []
infile.each_line do |line|
  report = line.split(' ')

  if is_safe(report)
    new_safe << line
  else
    # create new reports by removing each level once
    removed = []
    report.each_with_index do |r, i|
      removed << report[0...i].concat(report[i + 1...report.length]).to_a
    end

    safe_saved = []
    removed.each do |r|
      if is_safe(r)
        safe_saved << r
      end
    end
    if safe_saved.length > 0
      new_safe << line
    end
    unsafe << line
  end
end

puts "Part 2 solution"
puts new_safe.length
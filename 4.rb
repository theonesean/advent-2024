# process file into 2D grid

infile = File.read('input/4.txt')
GRID = []

infile.each_line do |line|
  GRID << line.strip!.split("")
end

# Part 1

# N: x, y - 1
# S: x, y + 1
# E: x - 1, y
# W: x + 1, y
# NE: x - 1, y - 1
# NW: x + 1, y - 1
# SE: x - 1, y + 1
# SW: x + 1, y + 1

DIRS = [
  [0, -1], # North
  [0, 1],  # South
  [-1, 0], # East
  [1, 0],  # West
  [-1, -1], # North-East
  [1, -1],  # North-West
  [-1, 1],  # South-East
  [1, 1]    # South-West
]
WIDTH, HEIGHT = GRID[0].size, GRID.size

def find_xmases(x, y)
  matches = 0

  return matches if GRID[y][x] != "X"
  
  # check all directions for "M"
  DIRS.each do |dx, dy|
    is_match = true

    ["M", "A", "S"].each_with_index do |l, i|
      nx, ny = x + (dx * (i + 1)), y + (dy * (i + 1))

      if nx < 0 || ny < 0
        is_match = false
        break
      end

      if nx >= WIDTH || ny >= HEIGHT
        is_match = false
        break
      end

      if GRID[ny][nx] != l
        is_match = false
        break
      end
    end

    matches += 1 if is_match
  end

  return matches

end

total_matches = 0

for x in (0... WIDTH)
  for y in (0... HEIGHT)
    total_matches += find_xmases(x, y)
  end
end

puts "Part 1 solution"
puts total_matches
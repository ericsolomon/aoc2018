import strutils, strscans, sequtils

let input = readFile("input.txt").strip().splitLines()

const
  MAX_X = 400
  MAX_Y = 400

type
  Grid = array[MAX_Y, array[MAX_X, int]]
  GridCoord = tuple
    x: int
    y: int
    marker: int

proc genCoords(): seq[GridCoord] =
  result = newSeq[GridCoord](input.len)

  var
    x: int
    y: int

  for i, line in input:
    if scanf(line, "$i, $i", x, y):
      result[i] = (x, y, i+1)

proc calcArea(grid: Grid, marker: int): int =
  for row in grid:
    for col in row:
      if marker == col:
        inc result

let coords = genCoords()

proc partOne(): int =
  var grid: Grid

  # generate grid regions
  for i, row in grid:
    for j, col in row:
      var
        closest = int.high
        distance: int

      for coord in coords:
        distance = (abs(coord.x - j) + abs(coord.y - i))
        if distance == closest:
          grid[i][j] = 0
        elif distance < closest:
          closest = distance
          grid[i][j] = coord.marker
          
  # find largest region that is not infinite
  for coord in coords:
    var
      area: int
      infinite: bool
  
    for i, row in grid:
      if i == 0 or i == grid.len-1:
        if coord.marker in row:
          infinite = true
          break

      if row[0] == coord.marker or row[^1] == coord.marker:
        infinite = true
        break

    if not infinite:
      area = calcArea(grid, coord.marker)
      if area > result:
        result = area

proc partTwo(): int =
  for i in 0..<MAX_X:
    for j in 0..<MAX_Y:
      if coords.map(func(coord: GridCoord): int = abs(coord.x - j) + abs(coord.y - i)).foldl(a + b) < 10000:
        inc result

echo "Area of largest non-infinite region: ", partOne()
echo "Area of safe region: ", partTwo()

import strscans, strutils, sequtils

let input = readFile("input.txt").splitLines.filter(proc(x: string): bool = x != "")

var
  claim: string
  x: int
  y: int
  width: int
  height: int
  fabric: array[1000, array[1000, int]]

proc partOne: int =
  for line in input:
    discard scanf(line, "$+ @ $i,$i: $ix$i", claim, x, y, width, height)
    for i in y..<(y + height):
      for j in x..<(x + width):
        inc fabric[i][j]

  for row in fabric:
    for col in row:
      if col > 1:
        inc result

proc isOverlappingClaim(claim: string, x: int, y: int, width: int, height: int): bool =
  for i in y..<(y + height):
    for j in x..<(x + width):
      if fabric[i][j] > 1:
        return true

proc partTwo: string =
  for line in input:
    discard scanf(line, "$+ @ $i,$i: $ix$i", claim, x, y, width, height)
    if not isOverlappingClaim(claim, x, y, width, height):
      return claim

echo "Collisions: ", partOne()
echo "Non-overlapping claim: ", partTwo()

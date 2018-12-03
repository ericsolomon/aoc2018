import strutils, sequtils

proc partOne: int =
  let input = readFile("input.txt").splitLines.filter(proc(x: string): bool = x != "")

  var
    twoCount = 0
    threeCount = 0

  for id in input:
    var
      foundTwo = false
      foundThree = false
    
    for ch in id.deduplicate():
      var count = id.count(ch)
    
      if count == 2 and not foundTwo:
        twoCount += 1
        foundTwo = true
      if count == 3 and not foundThree:
        threeCount += 1
        foundThree = true

      if foundTwo and foundThree:
        break

  result = twoCount * threeCount


proc stringDiff(x: string, y: string): int =
  result = -1
  
  for idx, ch in x:
    if ch != y[idx]:
      if result != -1:
        return -1

      result = idx

proc partTwo: string =
  let input = readFile("input.txt").splitLines.filter(proc(x: string): bool = x != "")

  for id1 in input:
    for id2 in input:
      let diffIdx = stringDiff(id1, id2)

      if diffIdx != -1:
        var foo = toSeq(id1.items)
        foo.delete(diffIdx, diffIdx)
        return foo.map(proc(x: char): string = $x).mapIt(string, $it).join()

echo "Checksum: ", partOne()
echo "Common Letters: ", partTwo()

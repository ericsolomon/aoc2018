import strutils, sequtils

proc partOne: int =
  result = 0  

  let input = open("input.txt")
  
  for line in input.lines:
    result += parseInt(line)

  input.close()

proc partTwo: int =
  result = 0

  let input = readFile("input.txt").splitLines.filter(proc(x: string): bool = x != "").map(parseInt)
  var seenFreqs = @[result]
  
  while true:
    for freq in input:
      result += freq
      if seenFreqs.contains(result):
        return result
      else:
        seenFreqs.add(result)

echo "Frequency: ", partOne()
echo "Dupe Freq: ", partTwo()

import strutils

var input = readFile("input.txt").strip

proc react(polymer: string): int =
  result = 0
  var
    stack: array[15000, char]

  for unit in polymer:
    if result > 0 and (ord(unit) == ord(stack[result-1]) + 32 or ord(unit) == ord(stack[result-1]) - 32):
      dec result
    else:
      stack[result] = unit
      inc result

proc findShortest(polymer: string): int =
  result = int.high

  for letter in {'a'..'z'}:
    let polymerLength = react(polymer.split({letter, letter.toUpperAscii}).join())
    if polymerLength < result:
      result = polymerLength

echo "Units remaining: ", react(input)
echo "Shortest polymer: ", findShortest(input)

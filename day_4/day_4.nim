import strutils, sequtils, strscans, times, algorithm, tables

let input = readFile("input.txt").splitLines.filter(proc(x: string): bool = x != "")

var
  timestamp: string
  guardId: int
  guardTable = initTable[int, seq[int]]()
  wakeTime: DateTime
  sleepTime: DateTime

for line in sorted(input, system.cmp):
  if scanf(line, "[$+] Guard #$i begins shift", timestamp, guardId):
    if not guardTable.hasKey(guardId):
      guardTable[guardId] = newSeq[int](60)
    wakeTime = parse(timestamp, "yyyy-MM-dd hh:mm")

  if scanf(line, "[$+] falls asleep", timestamp):
    sleepTime = parse(timestamp, "yyyy-MM-dd hh:mm")

  if scanf(line, "[$+] wakes up", timestamp):
    wakeTime = parse(timestamp, "yyyy-MM-dd hh:mm")
    let interval = wakeTime.minute - sleepTime.minute
    for minute in sleepTime.minute..<wakeTime.minute:
      inc guardTable[guardId][minute]

var
  sleepGuard: int
  sleepMinute: int
  sleepIndex: int
  maxMinutesSlept: int
  maxGuard: int

for guard, shift in guardTable:
  var minutesSlept = shift.foldl(a + b)
  if minutesSlept > maxMinutesSlept:
    maxGuard = guard
    maxMinutesSlept = minutesSlept
  for idx, minute in shift:
    if minute > sleepMinute:
      sleepGuard = guard
      sleepMinute = minute
      sleepIndex = idx

for idx, minute in guardTable[maxGuard]:
  if minute > sleepMinute:
    sleepMinute = minute
    sleepIndex = idx

echo "Part 1: ", maxGuard * sleepIndex
echo "Part 2: ", sleepGuard * sleepIndex

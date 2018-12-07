import strscans, sequtils, strutils, algorithm, tables

proc getSteps(input: seq[string]): OrderedTable[string, seq[string]]

let input = readFile("input.txt").strip.splitLines.sorted(system.cmp)

type
  Worker = object
    available: bool
    timeLeft: int
    step: string

var
  root: string
  blocked: string
  steps = getSteps(input)


proc getBlockers(steps: OrderedTable): seq[string] =
  result = @[]
  for _, v in steps:
    result = concat(result, v)

proc getSteps(input: seq[string]): OrderedTable[string, seq[string]] =
  result = initOrderedTable[string, seq[string]]()
  
  for line in input:
    if scanf(line, "Step $w must be finished before step $w can begin.", root, blocked):
      if not result.hasKey(root):
        result[root] = @[]
      if not result.hasKey(blocked):
        result[blocked] = @[]
      result[root].add(blocked)

  result.sort(proc(x, y: (string, seq[string])): int = result = cmp(x[0], y[0]))
  
proc partOne(): string =
  result = ""

  while steps.len > 0:
    for k, _ in steps:
      if getBlockers(steps).count(k) == 0:
        result = result & k
        steps.del(k)
        break

proc partTwo(): int =
  var
    workers: array[5, Worker]
    inProgress: seq[string] = @[]
    steps = getSteps(input)

  for i in low(workers)..high(workers):
    workers[i].available = true

  while steps.len > 0:
    inc result
    for i in low(workers)..high(workers):
      if workers[i].available:
        for k, _ in steps:
          if inProgress.count(k) == 0 and getBlockers(steps).count(k) == 0:
            workers[i].step = k
            workers[i].timeLeft = ord(k[0]) - 4
            workers[i].available = false
            inProgress.add(k)
            break
      if not workers[i].available:
        dec workers[i].timeLeft
        if workers[i].timeLeft == 0:
          workers[i].available = true
          steps.del(workers[i].step)
          keepItIf(inProgress, it != workers[i].step)
          for k, _ in steps:
            if inProgress.count(k) == 0 and getBlockers(steps).count(k) == 0:
              workers[i].step = k
              workers[i].timeLeft = ord(k[0]) - 4
              workers[i].available = false
              inProgress.add(k)
              break

echo "Order of steps: ", partOne()
echo "Time to complete steps: ", partTwo()

# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import std/[strutils,strformat,math]

type ELOPair = object
  plr: float
  opp: float

proc `$`(pair: ELOPair): string = fmt"[Player: {pair.plr} Opponent: {pair.opp}]"

proc newElo(old: ELOPair, plrscore: float, k: float): ELOPair =
  let expectedA = 1/(1+pow(10,(old.opp-old.plr)/400))
  let expectedB = 1-expectedA

  let oppscore = 1-plrscore
  return ELOPair(plr: round(old.plr+k*(plrscore-expectedA)), opp: round(old.opp+k*(oppscore-expectedB)))

proc acceptElo(): ELOPair =
  echo "==="
  stdout.write("Enter player's ELO: ")
  var pair: ELOPair;
  pair.plr = parseFloat(readLine(stdin))
  stdout.write("Enter opponent's ELO: ")
  pair.opp = parseFloat(readLine(stdin))
  echo "==="
  return pair

when isMainModule:
  echo("ELO (not E.L.O.)!")
  while true:
    let oldElo = acceptElo()
    stdout.write("Did the player win? [0-1]: ")
    echo "Final Result: " & $newElo(oldElo,parseFloat(readLine(stdin)),48)

#!/usr/bin/env python3

from subprocess import call
from time import sleep

START = 5000
STEP = 1000
SLEEP = 5
TODAYSTATS = "/home/exo/.workrave_home_data/todaystats"

def extract_keystrokes(todaystats_path: str) -> int:
    with open(todaystats_path, 'r') as f:
        return int(f.read().strip().split()[-1])

def execute_signal() -> None:
    call(["i3lock", "-c", "ff0000"])

def send_signal(start: int, step: int, wait: int) -> None:
    signals_done = []
    while True:
        keystrokes = extract_keystrokes(TODAYSTATS)
        if keystrokes > start:
            base = keystrokes // step
            if base * step not in signals_done:
                signals_done.append(base * step)
                execute_signal()
        else:
            signals_done = []
        #print(signals_done)
        sleep(wait * 60)

if __name__ == "__main__":
    send_signal(START, STEP, SLEEP)

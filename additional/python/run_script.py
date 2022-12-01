#!/usr/bin/python3
import sys
import subprocess
import os
import pathlib

arguments = sys.argv
arguments[0] = "/usr/bin/python3"

# Change directory to the same in which this file is
os.chdir(pathlib.Path(__file__).parent.resolve())

# Only allow files in the current directory 
assert(arguments[1].count("/") == 0 and arguments[1].endswith(".py"))
process = subprocess.Popen(arguments, stdout=subprocess.PIPE)

while True:
    output = process.stdout.readline()
    output = output.decode("utf-8")
    if output == "" and process.poll() is not None:
        break
    else:
        print(output, end='')

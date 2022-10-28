import re
import jessentials
import jfiles
import hashlib

FILE_PATH = "/tmp/linux_assistant_commands"


jessentials.ensure_root_privileges()

if not jfiles.does_file_exist(FILE_PATH):
    jessentials.fail(f"File '{FILE_PATH}' not found. Exiting..")

md5ChecksumFromExecutor = jessentials.get_value_from_arguments("md5", "")
file = open(FILE_PATH, "r")
string = file.read()

actualMd5Checksum = hashlib.md5(string.encode('utf-8')).hexdigest()

if md5ChecksumFromExecutor != actualMd5Checksum:
    jessentials.fail(f"Checksum test failed! Did anyone corrupt '{FILE_PATH}'?")

lines = string.strip().split("\n")

# Example of a line:
# "0";"apt update";"DEBIAN_NONINTERACTIVE='true'";

for line in lines:
    
    # Remove the '"...";' signs.
    line = line.strip()[1:-2]
    elements = line.split("\";\"")

    user_id = elements.pop(0)
    if user_id.isnumeric():
        user_id = int(user_id)
    command = elements.pop(0)
    env = {}
    for e in elements:
        key = e.split("=")[0]
        value = e.split("=")[1][1:-1]
        env[key] = value

    print(f"-- COMMAND: '{command}' ".ljust(128, "-"))
    jessentials.run_command(command=command, enviroment=env, user=user_id)

print(" FINISHED ".center(128, "-"))
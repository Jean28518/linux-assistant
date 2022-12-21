
import os
import re
import jessentials
import get_diskspace

# Get uptime
output = jessentials.run_command("/usr/bin/uptime", return_output=True, print_output=False)[0]
output = output.strip()
output = re.sub(' +', ' ', output)
uptime = output.split(" ")[2].replace(",", "")
if "day" in output:
    uptime = f"{uptime}days"
print(f"uptime: {uptime}")

# Get diskspaces
get_diskspace.main()

# Get zombies:
processes = jessentials.run_command("ps -eo stat", return_output=True, print_output=False)
print(f"processes: {len(processes)}")

zombies = 0
for process in processes:
    if process.strip() == "Z":
        zombies += 1
print(f"zombies: {zombies}")

# Removable devices
removable_devices = []
output = jessentials.run_command("df -h", return_output=True, print_output=False)
for line in output:
    if "/media/" in line:
        removable_devices.append(line)
    elif "/mnt/" in line:
        removable_devices.append(line)
print(f"removable_devices: {len(removable_devices)}")

# Swap
swaps = -1
if os.path.exists("/usr/sbin/swapon"):
    output = jessentials.run_command("/usr/sbin/swapon -s", return_output=True, print_output=False)
    swaps = len(output)
    # Remove column description
    if swaps > 1:
        swaps -= 1
print(f"swaps: {swaps}")


# Top Memory processes
print("Top 3 Memory:")
output = jessentials.run_command("ps -eo pmem,args --sort=-pmem", return_output=True, print_output=False)
for i in range (1, 4):
    memory = output[i].split(" ")[0]
    process = output[i].split(" ")[1].split("/")[-1]
    print(memory, process)

# Top CPU processes
print("Top 3 CPU:")
output = jessentials.run_command("ps -eo pcpu,args --sort=-pcpu", return_output=True, print_output=False)
for i in range (1, 4):
    cpu = output[i].split(" ")[0]
    process = output[i].split(" ")[1].split("/")[-1]
    print(cpu, process)


# Get files in desktop:
print("home files:")
home = os.getenv("HOME")
files = os.listdir(home)
for file in files:
    if os.path.isfile(os.path.join(home, file)):
        if not file.startswith("."):
            print(file)





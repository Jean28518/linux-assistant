import jessentials
import re

jessentials.ensure_root_privileges()
if jessentials.get_current_distribution() == "debian":
    jessentials.run_command("/usr/bin/apt-add-repository non-free")
jessentials.run_command("apt update")
output_lines = jessentials.run_command("apt search nvidia-driver-", return_output=True, print_output=False)
numbers = []
for line in output_lines:
    found = re.search('nvidia-driver-[0-9]{3}', line)
    if found:
        number = int(str(found.group(0)).replace("nvidia-driver-", ""))
        if numbers.count(number) == 0:
            numbers.append(number)
# print(output_lines)
if len(numbers) == 0:
    print("No nvidia drivers found on that distribution? Are there sources missing?")
    exit(1)
numbers.sort()
highest_number = numbers[-1]

jessentials.run_command(f"apt install -y nvidia-driver-{highest_number}", enviroment={'DEBIAN_FRONTEND': 'noninteractive'})
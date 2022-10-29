import jessentials


keyword = jessentials.get_value_from_arguments("keyword", "")
if keyword == "" :
    exit(0)

keyword = keyword.replace("'", "")

lines = jessentials.run_command(f"/usr/bin/apt-cache search  '{keyword}' --names-only", print_output=False, return_output=True)

installed_full = jessentials.run_command(f"/usr/bin/apt list --installed", print_output=False, return_output=True)
installed = []
for line in installed_full:
    installed.append(line.split("/")[0])


for line in lines:  
    if line.strip() == "":
        continue
    package = line.split(" - ")[0]
    if not package in installed:
        print(package)


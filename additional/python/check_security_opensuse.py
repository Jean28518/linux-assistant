import os
import jessentials
import jfolders
import jfiles
from check_home_folder_rights import check_home_folder_rights


def get_additional_sources():
    entries = jfolders.get_folder_entries("/etc/zypp/repos.d")
    for entry in entries:
        if ("opensuse" in entry.lower()):
            continue
        if ("repo-debug.repo" in entry.lower()):
            continue
        if ("repo-source.repo" in entry.lower()):
            continue
        lines = jfiles.get_all_lines_from_file(entry)

        name = ""
        for line in lines:
            if line.startswith("[") and line.strip().endswith("]"):
                name = line.replace("[", "").replace("]", "")
            if line.startswith("name="):
                name = line.replace("name=", "")
            if ("enabled=0" in line):
                name = ""
                break
        if name != "":
            print(f"additionalsource: {name}")

def get_available_updates():
    jessentials.run_command("zypper --non-interactive refresh", False, True, {'LC_ALL': 'C'})
    lines = jessentials.run_command("zypper --non-interactive list-updates", False, True, {'LC_ALL': 'C'})
    if len(lines) > 4:
        for i in range(len(lines)-4):
            print(f"upgradeablepackage: (to be implemented)")

def check_server_access():
    # Check for firewall
    if (jfiles.does_file_exist("/usr/bin/firewall-cmd")):
        lines = jessentials.run_command("/usr/bin/systemctl status firewalld", False, True)
        firewalldActive = False
        for line in lines:
            if "active (running)" in line:
                ufwUserFound = True
                break
        if not ufwUserFound:
            print("firewallinactive")
    else:
        print("nofirewall")
    
    # Check for Xrdp
    lines = jessentials.run_command("/usr/bin/systemctl status xrdp", False, True)
    if (len(lines) > 1):
        print("xrdprunning")
    # Check for ssh:
    lines = jessentials.run_command("/usr/bin/systemctl status ssh", False, True)
    if (len(lines) > 1):
        print("sshrunning")
        lines = jessentials.run_command("/usr/bin/systemctl status fail2ban", False, True)
        if (len(lines) == 0):
            print("fail2bannotrunning")

if __name__ == "__main__":
    jessentials.ensure_root_privileges()
    get_additional_sources()
    get_available_updates()
    check_home_folder_rights(jessentials.get_value_from_arguments("home", ""))
    check_server_access()
    print("#!script ran successfully.")

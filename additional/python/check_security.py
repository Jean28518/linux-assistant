import os
import jessentials
import jfolders
import jfiles


def get_additional_sources():
    entries = jfolders.get_folder_entries("/etc/apt/sources.list.d")
    for entry in entries:
        if "official-package-repositories.list" in entry: # Linux Mint
            continue
        if "debian.list" in entry: # MX Linux
            continue
        if "debian-stable-updates.list" in entry: # MX Linux
            continue
        if "mx.list" in entry: # MX Linux
            continue
        if "zorin.list" in entry: # ZorinOS
            continue
        if "zorinos-ubuntu-" in entry: # ZorinOS
            continue
        if "system.sources" in entry: # Pop!_OS
            continue
        lines = jfiles.get_all_lines_from_file(entry)

        for line in lines:
            line = str(line).lstrip()
            line = str(line).rstrip()
            if not line.startswith("#") and not len(line.strip()) == 0:
                line = line.strip()
                sections_raw = line.split(" ")

                # Remove whitespaces
                sections = []
                for section in sections_raw:
                    if len (section.strip()) > 0:
                        sections.append(section)
                
                # Only return the 3 important parts of the line
                length = len(sections)
                print(f"additionalsource: {sections[length-3]} {sections[length-2]} {sections[length-1]}")

def get_available_updates():
    jessentials.run_command("apt update", False, False, {'DEBIAN_FRONTEND': 'noninteractive'})
    lines = jessentials.run_command("apt list --upgradable", False, True, {'DEBIAN_FRONTEND': 'noninteractive'})
    for i in range(1, len(lines)):
        line = lines[i].strip().split("/")[0]
        print(f"upgradeablepackage: {line}")

def check_home_folder_rights(home_folder):
    # Doesn't work because script is run as root:
    # home_folder = jessentials.get_environment_variable("HOME")
    
    lines = jessentials.run_command(f"ls -al {home_folder}", False, True)
    if lines[1][7] != "-" or lines[1][8] != "-" or lines[1][9] != "-":
        print(f"homefoldernotsecure: {lines[1]}")

def check_server_access():
    # Check for Xrdp
    if (jfiles.does_file_exist("/usr/sbin/ufw")):
        lines = jessentials.run_command("/usr/sbin/iptables -L", False, True)
        ufwUserFound = False
        for line in lines:
            if "ufw-user" in line:
                ufwUserFound = True
                break
        if not ufwUserFound:
            print("firewallinactive")
    else:
        print("nofirewall")
    
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

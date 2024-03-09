import jessentials
import jfiles
import re

print("Enabling automatic snapshots...")
jessentials.ensure_root_privileges()
# Timeshift should have been installed before.
if not jfiles.does_file_exist("/etc/timeshift/timeshift.json"):
    jfiles.copy_file("/etc/timeshift/default.json", "/etc/timeshift/timeshift.json")
timeshift_config = jfiles.get_dict_of_json_file("/etc/timeshift/timeshift.json")
# Get all lines in /etc/fstab and search for the line with / as mount point
lines = jfiles.get_all_lines_from_file("/etc/fstab")
uuid = ""
mount = ""
filesystem = ""
for line in lines:
    line = line.replace("\t", " ")
    line = re.sub(' +', ' ', line) # Remove all multiple whitespaces within string
    if line.strip().startswith("#"):
        continue
    if "/ " in line:
        uuid = line.split(" ")[0].strip()
        mount = line.split(" ")[1].strip()
        filesystem = line.split(" ")[2].strip()
        break

if "UUID=" in uuid:
    uuid = uuid.replace("UUID=", "")
    
if len(uuid) == 36 and mount == "/" and (filesystem == "ext4" or filesystem == "btrfs"):
    timeshift_config["backup_device_uuid"] = uuid
    timeshift_config["schedule_monthly"] = "true"
    if "--daily" in jessentials.get_arguments():
        timeshift_config["schedule_daily"] = "true"
    timeshift_config["exclude"].append("/home/***")
    if filesystem == "btrfs":
        timeshift_config["btrfs_mode"] = "true"
    jfiles.write_dict_to_json_file(dict=timeshift_config, file_path="/etc/timeshift/timeshift.json")
    pass
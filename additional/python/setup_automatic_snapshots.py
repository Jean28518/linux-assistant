import jessentials
import jfiles
import re

print("Enabling automaitc snapshots...")
jessentials.ensure_root_privileges()
jessentials.run_command("apt update", environment={'DEBIAN_FRONTEND': 'noninteractive'})
jessentials.run_command("apt install -y timeshift", environment={'DEBIAN_FRONTEND': 'noninteractive'})
if not jfiles.does_file_exist("/etc/timeshift/timeshift.json"):
    jfiles.copy_file("/etc/timeshift/default.json", "/etc/timeshift/timeshift.json")
timeshift_config = jfiles.get_dict_of_json_file("/etc/timeshift/timeshift.json")
print(timeshift_config)
fstab_line = jfiles.get_value_from_file("/etc/fstab", "UUID").strip()
fstab_line = re.sub(' +', ' ', fstab_line) # Remove all multiple whitespaces within string
uuid = fstab_line.split(" ")[0]
mount = fstab_line.split(" ")[1]
filesystem = fstab_line.split(" ")[2]
if len(uuid) == 36 and mount == "/" and filesystem == "ext4":
    timeshift_config["backup_device_uuid"] = uuid
    timeshift_config["schedule_monthly"] = "true"
    timeshift_config["exclude"].append("/home/***")
    print(timeshift_config)
    jfiles.write_dict_to_json_file(dict=timeshift_config, file_path="/etc/timeshift/timeshift.json")
    pass

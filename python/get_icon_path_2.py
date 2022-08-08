import os
import jessentials

file = __file__
cwd = os.getcwd()
exec_path = f"{cwd}/{file}"
parts = exec_path.split("/")
parts.pop()
exec_folder = ""
for part in parts:
    exec_folder += part + "/"

# Very dirty but works in production mode and in debug mode
if "///" in exec_folder:
    exec_folder = exec_folder.split("///")[1]

jessentials.run_command("python3 %s/get_icon_path.py --icon=%s "  % (exec_folder, jessentials.get_value_from_arguments("icon")), enviroment= {"DISPLAY" : os.getenv("DISPLAY")})
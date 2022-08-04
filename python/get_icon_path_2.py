import os
import jessentials

jessentials.run_command("python3 python/get_icon_path.py --icon=%s " % jessentials.get_value_from_arguments("icon"), enviroment= {"DISPLAY" : os.getenv("DISPLAY")})
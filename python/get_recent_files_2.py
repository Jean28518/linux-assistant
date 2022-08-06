import os
import jessentials

jessentials.run_command("python3 python/get_recent_files.py", enviroment= {"DISPLAY" : os.getenv("DISPLAY")})
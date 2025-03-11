import jessentials

def check_home_folder_rights(home_folder):
    lines = jessentials.run_command(f"ls -al {home_folder}", False, True)
    # Check if the home folder has the right permissions for others (no permissions at all) and the right group permissions (no write permissions)
    if lines[1][7] != "-" or lines[1][8] != "-" or lines[1][9] != "-" or lines[1][5] != "-":
        print(f"homefoldernotsecure: {lines[1]}")
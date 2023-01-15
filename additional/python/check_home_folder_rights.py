import jessentials

def check_home_folder_rights(home_folder):
    lines = jessentials.run_command(f"ls -al {home_folder}", False, True)
    if lines[1][7] != "-" or lines[1][8] != "-" or lines[1][9] != "-":
        print(f"homefoldernotsecure: {lines[1]}")
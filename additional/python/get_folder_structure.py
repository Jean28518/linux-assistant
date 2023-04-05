import os
import jessentials

def does_folder_exist(folder_path):
    return os.path.isdir(folder_path)

def get_folders_in(folder_path, recursion_depth):
    if not does_folder_exist(folder_path) or recursion_depth == 0:
        return []
    return_value = []
    entries = os.scandir(folder_path)
    if not folder_path.endswith("/"):
        folder_path = folder_path + "/"
    for entry in entries:
        entry_name = entry.name
        # Ignore hidden folders
        if (entry_name.startswith(".")):
            continue
        # Only add folders
        if (os.path.isdir(folder_path + entry_name) and os.access(folder_path + entry_name, os.R_OK)):
            return_value.append(folder_path + entry_name + "/")
            new_entries = get_folders_in(folder_path + entry_name, recursion_depth - 1)
            for e in new_entries:
                return_value.append(e)
    return return_value

def add_arrays(arr1, arr2):
    for e in arr2:
        arr1.append(e)
    return arr1


if __name__ == '__main__':
    home_folder = os.getenv("HOME")
    entries = get_folders_in(home_folder, int(jessentials.get_value_from_arguments("recursion_depth", 2)))   
    for e in entries:
        print(e)
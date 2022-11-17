import os

def does_folder_exist(folder_path):
    folder_path = folder_path
    return os.path.isdir(folder_path)

def get_folders_in(folder_path):
    if not does_folder_exist(folder_path):
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
        if (os.path.isdir(folder_path + entry_name)):
            return_value.append(folder_path + entry_name + "/")
    return return_value

def add_arrays(arr1, arr2):
    for e in arr2:
        arr1.append(e)
    return arr1


if __name__ == '__main__':
    home_folder = os.getenv("HOME")
    entries = get_folders_in(home_folder)
    return_value = []
    return_value = add_arrays(return_value, entries)
    for entry in entries:
        return_value = add_arrays(return_value, get_folders_in(entry))
    
    for e in return_value:
        print(e)
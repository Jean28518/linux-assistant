# GitHub repository: https://github.com/Jean28518/jtools-unix-python
# License: Apache License 2.0

import os

def touch_folder(folder_path):
    folder_path = replace_tilde_to_home(folder_path)
    folders = folder_path.split("/")
    folder_path = ""
    for folder in folders:
        if folder == "":
            continue
        if not os.path.isdir(folder_path + "/" + folder):
            os.mkdir(folder_path + "/" + folder)
        folder_path = folder_path + "/" + folder

def does_folder_exist(folder_path):
    folder_path = replace_tilde_to_home(folder_path)
    return os.path.isdir(folder_path)

def replace_tilde_to_home(folder_path):
    return folder_path.replace("~", os.environ['HOME'])

def get_folder_entries(folder_path):
    folder_path = replace_tilde_to_home(folder_path)
    if not does_folder_exist(folder_path):
        return []
    return_value = []
    entries = os.scandir(folder_path)
    if not folder_path.endswith("/"):
        folder_path = folder_path + "/"
    for entry in entries:
        entry_name = entry.name
        return_value.append(folder_path + entry_name)
    return return_value

def get_folder_entry_names(folder_path):
    folder_path = replace_tilde_to_home(folder_path)
    if not does_folder_exist(folder_path):
        return []
    return_value = []
    entries = os.scandir(folder_path)
    for entry in entries:
        return_value.append(str(entry.name))
    return return_value

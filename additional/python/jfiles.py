# GitHub repository: https://github.com/Jean28518/jtools-unix-python
# License: Apache License 2.0

import gettext
import json
import os

def does_file_exist(file_path):
    return os.path.exists(file_path) and os.path.isfile(file_path)

def get_line_numbers_with_phrase(file_path, phrase):
    if not does_file_exist(file_path):
        return []
    text = open(file_path, 'r')

    return_array = []
    i = 1
    for line in text.readlines():
        if line.find(phrase) != -1:
            return_array.append(i)
        i += 1
    text.close()
    return return_array

def append_line_to_file(file_path, line):
    add_newline = False
    if does_file_exist(file_path):
        add_newline = True
    text = open(file_path, 'a')
    if add_newline:
        text.write('\n')
    text.write(line)
    text.close()
    return True

def get_all_lines_from_file(file_path):
    if not does_file_exist(file_path):
        return []
    text = open(file_path, 'r')

    return_array = []
    i = 1
    for line in text.readlines():
        return_array.append(line)
    text.close()
    return return_array

def remove_line_numbers_from_file(file_path, line_numbers):
    if not does_file_exist(file_path):
        return False
    lines = get_all_lines_from_file(file_path)
    text = open(file_path, 'w')
    for i, line in enumerate(lines):
        if (i+1) not in line_numbers:
            text.write(line)
    text.close()
    return 0

def remove_all_lines_with_phrase_from_file(file_path, phrase):
    if not does_file_exist(file_path):
        return False
    lines_to_remove = get_line_numbers_with_phrase(file_path, phrase)
    return remove_line_numbers_from_file(file_path, lines_to_remove)

def remove_lines_from_file(file_path, lines):
    if not does_file_exist(file_path):
        return False
    lines_to_remove = get_line_numbers_from_lines_in_file(file_path, lines)
    return remove_line_numbers_from_file(file_path, lines_to_remove)

def get_line_numbers_from_lines_in_file(file_path, lines):
    if not does_file_exist(file_path):
        return []
    original_lines = get_all_lines_from_file(file_path)
    line_numbers = []
    for i, line in enumerate(original_lines):
        line_without_nl = line
        for searched_line in lines:
            if line_without_nl.replace("\n", "") == searched_line:
                line_numbers.append(i+1)
    return line_numbers

def set_line_numbers_to_line_in_file(file_path, line_numbers, new_line):
    if not does_file_exist(file_path):
        return False
    original_lines = get_all_lines_from_file(file_path)

    # Remove invalid or duplicate numbers
    line_numbers_cleaned = []
    for line_number in line_numbers:
        if line_number > 0 and not line_number in line_numbers_cleaned:
            line_numbers_cleaned.append(line_number)

    # if len(line_numbers_cleaned) == 0:
    #     return 0

    text = open(file_path, 'w')
    i = 1
    while(len(line_numbers_cleaned) != 0 or (i-1) < len(original_lines)):
        # If we are in the original size of the file
        if (i-1) < len(original_lines):
            # just copy the original lines
            if not i in line_numbers_cleaned:
                text.write(original_lines[i-1])
            # dont copy the old line, write the new_line
            else:
                text.write(new_line + "\n")
                line_numbers_cleaned.remove(i)
        # if the original size of file is smaller than the highest line_number:
        else:
            # write empty lines
            if not i in line_numbers_cleaned:
                text.write("")
            #write the new_line
            else:
                text.write(new_line + "\n")
                line_numbers_cleaned.remove(i)

        i += 1


    text.close()
    return True


def replace_lines_in_file(file_path, line_to_replace, new_line):
    if not does_file_exist(file_path):
        return False
    line_numbers = get_line_numbers_from_lines_in_file(file_path, [line_to_replace])
    return(set_line_numbers_to_line_in_file(file_path, line_numbers, new_line))

def get_value_from_file(file_path, value_key, default=None):
    if not does_file_exist(file_path):
        return default
    lines = get_all_lines_from_file(file_path)
    for line in lines:
        if line.startswith(value_key + "="):
            if len(line) <= len(value_key)+2: # if line: "value_key="
                return default
            return_value = line[len(value_key)+1:]
            return_value = return_value.replace("\n", "")
            return_value = return_value.replace("!@/n", "\n")
            return return_value
    return default

def set_value_in_file(file_path, value_key, value):
    value_key = value_key.replace("=", "_")
    value = value.replace('\n', "!@/n")
    if not does_file_exist(file_path):
        append_line_to_file(file_path, value_key + "=" + str(value))
        return

    lines = get_all_lines_from_file(file_path)
    text = open(file_path, 'w')
    value_written = False
    for line in lines:
        if line.startswith(value_key + "="):
            text.write(value_key + "=" + str(value) + "\n")
            value_written = True
        else:
            text.write(line)
    text.close()
    if not value_written:
        append_line_to_file(file_path, value_key + "=" + str(value))

# Overwrites existing file
def write_lines_to_file(file_path, lines = []):
    if does_file_exist(file_path):
        os.remove(file_path)
    for line in lines:
        line = line.replace("\n", "")
        append_line_to_file(file_path, line)


def get_string_of_file(file_path):
    return open(file_path, 'r').read()


def copy_file(source_path, destination_path):
    os.system("cp '" + source_path + "' '" + destination_path + "'")

def get_dict_of_json_file(file_path):
    return json.load(open(file_path, 'r'))

## Overwrites the existent file
def write_dict_to_json_file(dict, file_path):
    return json.dump(dict, open(file_path, 'w'), ensure_ascii=False, indent=2)
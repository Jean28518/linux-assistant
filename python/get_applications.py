import os
import jessentials
import jfolders
import jfiles

class app_entry:
    def __init__(self, path, name, description, icon, keywords):
        self.path = path
        self.name = name
        self.description = description
        self.icon = icon
        self.keywords = keywords

def get_value_of_line(line: str):
    position = line.find("=")
    return_value = line[position+1:]
    return_value = return_value.replace("\n", "")
    return_value = return_value.replace("!@/n", "\n")
    return return_value


def get_applications_of_dir(path, language):
    files = jfolders.get_folder_entries(path)
    return_value = []
    
    for file in files:
        if not jfiles.does_file_exist(file):
            continue
        lines = jfiles.get_all_lines_from_file(file)
        name, description, icon, keywords = "", "", "", ""
        skip = False
        for line in lines:
            if line.startswith("Name="):
                name = get_value_of_line(line)
            if line.startswith("Name[%s]=" % language):
                name = get_value_of_line(line)
            if line.startswith("Comment="):
                description = get_value_of_line(line)
            if line.startswith("Comment[%s]=" % language):
                description = get_value_of_line(line)
            if line.startswith("Icon="):
                icon = get_value_of_line(line)
            if line.startswith("Keywords="):
                keywords = get_value_of_line(line)
            if line.startswith("NoDisplay=true"):
                skip = True
            # We don't want to add the action, because then e.g. the name get's weird
            if line.startswith("[Desktop Action"):
                break
        if name != "" and not skip:
            app = app_entry(file, name, description, icon, keywords)
            return_value.append(app)
            

    return return_value

if __name__ == '__main__':
    language = jessentials.get_value_from_arguments("lang", "en")

    dataDirs = os.getenv("XDG_DATA_DIRS").split(":")

    return_value = []
    for dataDir in dataDirs:
        dataDir += "/applications/"
        return_value = jessentials.add_arrays(get_applications_of_dir(dataDir, language), return_value)
    

    for app in return_value:
        print("%s\t%s\t%s\t%s\t%s" % (app.path, app.name, app.description, app.icon, app.keywords))


    
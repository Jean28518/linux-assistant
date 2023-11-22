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


def get_applications_of_dir(path, language, desktop):
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
            if line.startswith("OnlyShowIn=") and not desktop.lower() in line.lower() and desktop != "":
                skip = True
            # We don't want to add the action, because then e.g. the name get's weird
            if line.startswith("[Desktop Action"):
                break
        # If a appdata meta file exists, we want to use it
        files = jfolders.get_folder_entries("/usr/share/metainfo")
        for file in files:
            if name in file:
                lines = jfiles.get_all_lines_from_file(file)
                for line in lines:
                    if f"<name xml:lang=\"{language}\">" in line:
                        name = line.replace(f"<name xml:lang=\"{language}\">", "").replace("</name>", "").strip()
                    if f"<summary xml:lang=\"{language}\">" in line:
                        description = line.replace(f"<summary xml:lang=\"{language}\">", "").replace("</summary>", "").strip()
                    
        if name != "" and not skip:
            app = app_entry(file, name, description, icon, keywords)
            return_value.append(app)
            

    return return_value

if __name__ == '__main__':
    language = jessentials.get_value_from_arguments("lang", "en")
    desktop = jessentials.get_value_from_arguments("desktop", "")

    desktop = desktop.lower().replace("desktops", "")
    desktop = desktop.lower().replace("desktop", "")
    desktop = desktop.replace(".", "")
    desktop = desktop.replace("-", "")

    dataDirs = os.getenv("XDG_DATA_DIRS").split(":")

    if jfolders.does_folder_exist(os.getenv("HOME") + "/.local/share/applications"):
        dataDirs.append(os.getenv("HOME") + "/.local/share")

    return_value = []
    for dataDir in dataDirs:
        dataDir += "/applications/"
        return_value = jessentials.add_arrays(get_applications_of_dir(dataDir, language, desktop), return_value)
    

    for app in return_value:
        print("%s\t%s\t%s\t%s\t%s" % (app.path, app.name, app.description, app.icon, app.keywords))


    
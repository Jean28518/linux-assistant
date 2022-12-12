import os
import sqlite3
import jfolders
import jfiles
import jessentials
    
def main():

    # Firefox
    if jfolders.does_folder_exist("~/.mozilla/firefox/"):
        entries = jfolders.get_folder_entries("~/.mozilla/firefox/")
        for entry in entries:
            # We are using not .endswith in here because some distros have custom .default profile folder names.
            if not ".default" in entry:
                continue

            connection = sqlite3.connect(f"{entry}/places.sqlite", timeout=0.5)
            cursor = connection.cursor()

            try:
                for row in cursor.execute("SELECT moz_bookmarks.title, moz_places.url FROM moz_bookmarks JOIN moz_places WHERE moz_bookmarks.fk == moz_places.id"):
                    print(row[0] + "\t" + row[1])
            except:
                # Database busy
                pass
 
    # Chromium/Chrome
    entires = []
    entries = jessentials.add_arrays(jfolders.get_folder_entries("~/.config/chromium/"), entries)
    entries = jessentials.add_arrays(jfolders.get_folder_entries("~/.config/google-chrome/"), entries)
    entries = jessentials.add_arrays(jfolders.get_folder_entries("~/.var/app/org.chromium.Chromium/config/chromium/"), entries)
    entries = jessentials.add_arrays(jfolders.get_folder_entries("~/.var/app/com.google.Chrome/config/google-chrome/"), entries)
    for entry in entries:
        if not entry.split("/")[-1].startswith("Profile"):
            continue
        if not jfiles.does_file_exist(f"{entry}/Bookmarks"):
            continue
        print(entry)

        file = open(f"{entry}/Bookmarks", "r")
        json = jessentials.import_json_string(file.read())
        for location in ["bookmark_bar", "other", "synced"]:
            for entry in json["roots"][location]["children"]:
                print(entry["name"] + "\t" + entry["url"])
        
           
        
    
if __name__ == '__main__':
    main()
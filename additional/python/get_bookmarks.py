import os
import sqlite3
import jfolders
import jfiles
import jessentials
import shutil
    
def main():

    # Firefox
    firefoxDir = "~/.mozilla/firefox/"

    # Check if firefox is installed as snap (default on Ubuntu).
    if shutil.which("snap") is not None and os.system("snap list firefox") == 0:
        firefoxDir = "~/snap/firefox/common/.mozilla/firefox"

    if jfolders.does_folder_exist(firefoxDir):
        tmpDir = "/tmp/linux-assistant"
        tmpFileUsed = False

        entries = jfolders.get_folder_entries(firefoxDir)
        for entry in entries:
            # We are using not .endswith in here because some distros have custom .default profile folder names.
            if not ".default" in entry:
                continue
            
            dbFile = f"{entry}/places.sqlite"
            
            # If sqlite-wal file exists, the file 'places.sqlite' is opened by Firefox, which has an
            # exclusive lock on the database so we can't read from it. Therefore we need to create
            # a temporary copy.
            if os.path.exists(f"{entry}/places.sqlite-wal"):
                # Create temp directory, if it does not exist.
                if not os.path.exists(tmpDir):
                    os.mkdir(tmpDir, 0o700)
                
                # Create a copy of the database file.
                newDbFile = f"{tmpDir}/places.sqlite"
                shutil.copyfile(dbFile, newDbFile)
                dbFile = newDbFile
                
                tmpFileUsed = True

            connection = sqlite3.connect(dbFile, timeout=0.5)
            cursor = connection.cursor()

            try:
                for row in cursor.execute("SELECT moz_bookmarks.title, moz_places.url FROM moz_bookmarks JOIN moz_places WHERE moz_bookmarks.fk == moz_places.id"):
                    print(row[0] + "\t" + row[1])
            except Exception as ex:
                print(f"Failed to read data from sqlite database: {dbFile}")
                print(ex)
                pass
            finally:
                connection.close()
        
        # Delete the temporary database file after we're done with it.
        if tmpFileUsed:
            try:
                os.remove(dbFile)
            except Exception as ex:
                print(f"Failed to remove temporary file: {dbFile}")
                print(ex)
 
    # Chromium/Chrome
    entries = []
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
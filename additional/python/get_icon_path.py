import gi
import os

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

import jessentials
import jfolders
import jfiles

icon_name = jessentials.get_value_from_arguments("icon")

# Assume path
if len(icon_name.split("/")) > 3:
    print(icon_name)
    exit(0)

icon_theme = Gtk.IconTheme.get_default()
icon = icon_theme.lookup_icon(icon_name, 128, 0)
if icon:
    print(icon.get_filename())
else:
    logo_folder_path = jessentials.get_value_from_arguments('path-to-alternative-logos')
    for entry in jfolders.get_folder_entries(logo_folder_path):
        if entry.replace(".png", "").split("/")[-1] == icon_name:
            print(entry)
            exit(0)
    print("not found")
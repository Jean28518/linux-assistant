import gi
from gi.repository import Gio

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk


import jessentials


file_path = jessentials.get_value_from_arguments("file")


file_path = file_path.removeprefix("'").removesuffix("'")

# return an empty path if something doesn't work
icon_path = "" 

try:
    info = Gio.File.new_for_path(file_path).query_info('standard::icon', Gio.FileQueryInfoFlags.NONE, None)
    icon = info.get_icon()

    if icon:
        icon_names = icon.get_names()
        
        # ensure that the list is not empty
        if icon_names:
            theme = Gtk.IconTheme.get_default()
            size = 48
            
            icon_name = icon_names[0]
            
            icon_info = theme.lookup_icon(icon_name, size, 0)
            
            # ensure that lookup found something
            if icon_info: 
                icon_path = icon_info.get_filename()

except Exception as e:
    # catches all unexpected errors (e.g., file access errors)
    # and ensures that the program does not crash.
    pass

# new output
print(icon_path)

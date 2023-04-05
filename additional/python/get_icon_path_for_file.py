import gi
from gi.repository import Gio

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk


import jessentials

file_path = jessentials.get_value_from_arguments("file")


file_path = file_path.removeprefix("'").removesuffix("'")

info = Gio.File.new_for_path(file_path).query_info('standard::icon', Gio.FileQueryInfoFlags.NONE, None)
icon = info.get_icon()

if icon:
    theme = Gtk.IconTheme.get_default()
    size = 48
    icon_name = info.get_icon().get_names()[0]
    icon_path = theme.lookup_icon(icon_name, size, 0).get_filename()
    print(icon_path)
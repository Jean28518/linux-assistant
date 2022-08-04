import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

import jessentials

icon_name = jessentials.get_value_from_arguments("icon")
icon_theme = Gtk.IconTheme.get_default()
icon = icon_theme.lookup_icon(icon_name, 96, 0)
if icon:
    print(icon.get_filename())
else:
    print("not found")
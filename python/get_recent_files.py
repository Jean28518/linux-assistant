import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

recent_manager = Gtk.RecentManager.get_default();
items = recent_manager.get_items()
for item in items:
    if item and item.exists():
        file_path = item.get_uri().replace("file://", "")
        file_path = file_path.replace("%20", " ")
        print(f"{file_path}")

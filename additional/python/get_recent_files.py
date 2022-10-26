import gi
import urllib.parse

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

recent_manager = Gtk.RecentManager.get_default();
items = recent_manager.get_items()

for item in items:
    if item and item.exists():
        file_path = item.get_uri().replace("file://", "")
        file_path = urllib.parse.unquote(file_path)
        print(f"{file_path}")

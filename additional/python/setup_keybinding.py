from gi.repository import Gio
import jessentials
import json
import os

# Cinnamon ----------------------------------------------------------------------------------
CUSTOM_KEYS_PARENT_SCHEMA_CINNAMON = "org.cinnamon.desktop.keybindings"
CUSTOM_KEYS_BASENAME_CINNAMON = "/org/cinnamon/desktop/keybindings/custom-keybindings"
CUSTOM_KEYS_SCHEMA_CINNAMON = "org.cinnamon.desktop.keybindings.custom-keybinding"
DUMMY_CUSTOM_ENTRY_CINNAMON = "__dummy__"

def add_linux_assistant_keybinding_cinnamon():
    parent = Gio.Settings.new(CUSTOM_KEYS_PARENT_SCHEMA_CINNAMON)

    # Generate new name
    array = parent.get_strv("custom-list")
    num_array = []
    for entry in array:
        if entry == DUMMY_CUSTOM_ENTRY_CINNAMON:
            continue
        num_array.append(int(entry.replace("custom", "")))
    num_array.sort()
    i = 0
    while True:
        if i in num_array:
            i += 1
        else:
            break
    new_str = "custom" + str(i)
    array.append(new_str)
    parent.set_strv("custom-list", array)
    custom_name = f"custom{i}"

    # Insert new keybinding entry
    custom_path = f"{CUSTOM_KEYS_BASENAME_CINNAMON}/{custom_name}/"
    new_schema = Gio.Settings.new_with_path(CUSTOM_KEYS_SCHEMA_CINNAMON, custom_path)
    new_schema.set_string("name", "linux-assistant")
    new_schema.set_string("command", "linux-assistant")
    new_schema.set_strv("binding", ['<Super>q'])
    new_schema.sync()
    new_schema.apply()

    # Touch the custom-list key, this will trigger a rebuild in cinnamon
    parent = Gio.Settings.new(CUSTOM_KEYS_PARENT_SCHEMA_CINNAMON)
    custom_list = parent.get_strv("custom-list")
    custom_list.reverse()
    parent.set_strv("custom-list", custom_list)

# Gnome ----------------------------------------------------------------------------------
CUSTOM_KEYS_PARENT_SCHEMA_GNOME = "org.gnome.settings-daemon.plugins.media-keys"
CUSTOM_KEYS_BASENAME_GNOME = "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
CUSTOM_KEYS_SCHEMA_GNOME = "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"

def add_linux_assistant_keybinding_gnome():
    parent = Gio.Settings.new(CUSTOM_KEYS_PARENT_SCHEMA_GNOME)

    # Generate new name
    array = parent.get_strv("custom-keybindings")
    num_array = []
    for entry in array:
        if "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom" in entry:
            num_array.append(int(entry.replace("/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom", "").replace("/", "")))
    num_array.sort()
    i = 0
    while True:
        if i in num_array:
            i += 1
        else:
            break
    custom_name = f"custom{i}"
    array.append(f"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/{custom_name}/")
    parent.set_strv("custom-keybindings", array)

    # Insert new keybinding entry
    custom_path = f"{CUSTOM_KEYS_BASENAME_GNOME}/{custom_name}/"
    new_schema = Gio.Settings.new_with_path(CUSTOM_KEYS_SCHEMA_GNOME, custom_path)
    new_schema.set_string("name", "linux-assistant")
    new_schema.set_string("command", "linux-assistant")
    new_schema.set_string("binding", "<Super>q")
    new_schema.sync()
    new_schema.apply()

    # Touch the custom-list key, this will trigger a rebuild in gnome
    parent = Gio.Settings.new(CUSTOM_KEYS_PARENT_SCHEMA_GNOME)
    custom_list = parent.get_strv("custom-keybindings")
    custom_list.reverse()
    parent.set_strv("custom-keybindings", custom_list)

def add_linux_assistant_keybinding_xfce():
    jessentials.run_command("xfconf-query -c xfce4-keyboard-shortcuts -p '/commands/custom/<Super>q' -n -t string -s linux-assistant")

def main():
    if "cinnamon" in os.getenv("XDG_CURRENT_DESKTOP").lower():
        add_linux_assistant_keybinding_cinnamon()
    if "gnome" in os.getenv("XDG_CURRENT_DESKTOP").lower():
        add_linux_assistant_keybinding_gnome()
    if "xfce" in os.getenv("XDG_CURRENT_DESKTOP").lower():
        add_linux_assistant_keybinding_xfce()

if __name__ == "__main__":
    main()
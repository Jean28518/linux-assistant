from gi.repository import Gio
import jessentials
import json
import os

CUSTOM_KEYS_PARENT_SCHEMA = "org.cinnamon.desktop.keybindings"
CUSTOM_KEYS_BASENAME = "/org/cinnamon/desktop/keybindings/custom-keybindings"
CUSTOM_KEYS_SCHEMA = "org.cinnamon.desktop.keybindings.custom-keybinding"
DUMMY_CUSTOM_ENTRY = "__dummy__"

def add_linux_assistant_keybinding_cinnamon():
    parent = Gio.Settings.new(CUSTOM_KEYS_PARENT_SCHEMA)

    # Generate new name
    array = parent.get_strv("custom-list")
    num_array = []
    for entry in array:
        if entry == DUMMY_CUSTOM_ENTRY:
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
    custom_path = f"{CUSTOM_KEYS_BASENAME}/{custom_name}/"
    new_schema = Gio.Settings.new_with_path(CUSTOM_KEYS_SCHEMA, custom_path)
    new_schema.set_string("name", "linux-assistant")
    new_schema.set_string("command", "linux-assistant")
    new_schema.set_strv("binding", ['<Alt>q'])
    new_schema.sync()
    new_schema.apply()

    # Touch the custom-list key, this will trigger a rebuild in cinnamon
    parent = Gio.Settings.new(CUSTOM_KEYS_PARENT_SCHEMA)
    custom_list = parent.get_strv("custom-list")
    custom_list.reverse()
    parent.set_strv("custom-list", custom_list)


def main():
    if "cinnamon" in os.getenv("XDG_CURRENT_DESKTOP").lower():
        add_linux_assistant_keybinding_cinnamon()

if __name__ == "__main__":
    main()
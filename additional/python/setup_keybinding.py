from gi.repository import Gio
import jessentials
import jfiles
import jfolders
import os

# Cinnamon ----------------------------------------------------------------------------------
CUSTOM_KEYS_PARENT_SCHEMA_CINNAMON = "org.cinnamon.desktop.keybindings"
CUSTOM_KEYS_BASENAME_CINNAMON = "/org/cinnamon/desktop/keybindings/custom-keybindings"
CUSTOM_KEYS_SCHEMA_CINNAMON = "org.cinnamon.desktop.keybindings.custom-keybinding"
DUMMY_CUSTOM_ENTRY_CINNAMON = "__dummy__"

KEY_MODIFIER = "<Super>"

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
    new_schema.set_strv("binding", [f"{KEY_MODIFIER}q"])
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
    new_schema.set_string("binding", f"{KEY_MODIFIER}q")
    new_schema.sync()
    new_schema.apply()

    # Touch the custom-list key, this will trigger a rebuild in gnome
    parent = Gio.Settings.new(CUSTOM_KEYS_PARENT_SCHEMA_GNOME)
    custom_list = parent.get_strv("custom-keybindings")
    custom_list.reverse()
    parent.set_strv("custom-keybindings", custom_list)

# Xfce ----------------------------------------------------------------------------------

def add_linux_assistant_keybinding_xfce():
    jessentials.run_command(f"xfconf-query -c xfce4-keyboard-shortcuts -p '/commands/custom/{KEY_MODIFIER}q' -n -t string -s linux-assistant")

# KDE ----------------------------------------------------------------------------------

def add_linux_assistant_keybinding_kde():
    lines = jfiles.get_all_lines_from_file(jfolders.replace_tilde_to_home("~/.config/khotkeysrc"))

    newDataNumber = -1

    khotkeysrc_text = ""

    for i in range(len(lines)):
        if lines[i].strip() == "[Data]":
            newDataNumber = int(lines[i+1].replace("DataCount=", "")) + 1
            lines[i+1] = f"DataCount={newDataNumber}"

        if lines[i].strip() == "[General]":
            lines.insert(i, f"""[Data_{newDataNumber}]
Comment=Open linux-assistant
Enabled=true
Name=linux-assistant
Type=SIMPLE_ACTION_DATA

[Data_{newDataNumber}Actions]
ActionsCount=1

[Data_{newDataNumber}Actions0]
CommandURL=linux-assistant
Type=COMMAND_URL

[Data_{newDataNumber}Conditions]
Comment=
ConditionsCount=0

[Data_{newDataNumber}Triggers]
Comment=Simple_action
TriggersCount=1

[Data_{newDataNumber}Triggers0]
Key=Alt+Q
Type=SHORTCUT
Uuid={{c3daee14-f3bd-49db-bb5f-0a31a4b7fa73}}
""")
            break     

    jfiles.write_lines_to_file(jfolders.replace_tilde_to_home("~/.config/khotkeysrc"), lines)


    lines = jfiles.get_all_lines_from_file(jfolders.replace_tilde_to_home("~/.config/kglobalshortcutsrc"))
    for i in range(len(lines)):
        if (lines[i].startswith("[khotkeys]")):
            lines.insert(i+2, "{c3daee14-f3bd-49db-bb5f-0a31a4b7fa73}=Alt+Q,none,linux-assistant")
            break
    
    jfiles.write_lines_to_file(jfolders.replace_tilde_to_home("~/.config/kglobalshortcutsrc"), lines)

  


def main():
    global KEY_MODIFIER
    if jessentials.is_argument_option_given("alt", "a"):
        KEY_MODIFIER = "<Alt>"
    else:
        pass
    
    if "cinnamon" in os.getenv("XDG_CURRENT_DESKTOP").lower():
        add_linux_assistant_keybinding_cinnamon()
    if "gnome" in os.getenv("XDG_CURRENT_DESKTOP").lower():
        add_linux_assistant_keybinding_gnome()
    if "xfce" in os.getenv("XDG_CURRENT_DESKTOP").lower():
        add_linux_assistant_keybinding_xfce()
    if "kde" in os.getenv("XDG_CURRENT_DESKTOP").lower():
        add_linux_assistant_keybinding_kde()

if __name__ == "__main__":
    main()
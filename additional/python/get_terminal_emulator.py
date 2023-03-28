# This script will enumerate a list of possibly installed
# terminal emulators and will output the first one that is found in PATH.
#
# If you have more than one of these terminals installed,
# set your preferred one as the first element of the list.

import shutil

terminal_emulators = [
    "gnome-terminal",
    "konsole",
    "xfce4-terminal",
    "xterm"
]

for term in terminal_emulators:
    if shutil.which(term) is not None:
        print(term)
        break

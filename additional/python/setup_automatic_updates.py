import jessentials
import jfiles
from gi.repository import Gio

jessentials.ensure_root_privileges()
if jfiles.does_file_exist("/usr/bin/mintupdate-automation"):
    jessentials.run_command("mintupdate-automation upgrade enable")
    jessentials.run_command("mintupdate-automation autoremove enable")

    # Enable flatpak and spices update:
    # Has to be run without root!
    # settings = Gio.Settings(schema_id="com.linuxmint.updates")
    # settings.set_boolean("auto-update-cinnamon-spices", True)
    # settings.set_boolean("auto-update-flatpaks", True)
    exit(0)


jessentials.run_command("apt install unattended-upgrades")
jessentials.run_command("echo unattended-upgrades unattended-upgrades/enable_auto_updates boolean true | debconf-set-selections")
jessentials.run_command("/usr/sbin/dpkg-reconfigure -f noninteractive unattended-upgrades")
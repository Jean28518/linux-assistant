import jfiles
import jessentials

def getDistribution():
    return jfiles.get_value_from_file("/etc/os-release", "NAME", "").replace("\"", "")
    
def getVersionId():
    string = jfiles.get_value_from_file("/etc/os-release", "VERSION", "-1").replace("\"", "")
    # We need this because Linux Mint writes the codename behind the version:
    return string.split(" ")[0]

def getDesktop():
    return jessentials.get_environment_variable("XDG_CURRENT_DESKTOP", "Gnome")

def getLanguage():
    return jessentials.get_environment_variable("LANG").split("_")[0]

def getDefaultBrowser():
    lines = jessentials.run_command("xdg-settings get default-web-browser", False, True)
    if len(lines) > 0:
        return lines[0].replace(".desktop", "")
    else:
        return ""

def getSessionType():
    return jessentials.get_environment_variable("XDG_SESSION_TYPE", "x11")


print(f"{getDistribution()}\n{getVersionId()}\n{getDesktop()}\n{getLanguage()}\n{getDefaultBrowser()}\n{getSessionType()}")

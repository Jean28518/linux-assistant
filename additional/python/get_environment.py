import jfiles
import jessentials

def getDistribution():
    return jfiles.get_value_from_file("/etc/os-release", "NAME", "").replace("\"", "")
    
def getVersionId():
    string = jfiles.get_value_from_file("/etc/os-release", "VERSION", "-1").replace("\"", "")
    # We need this because Linux Mint writes the codename behind the version:
    string = string.split(" ")[0]
    return float(string)

def getDesktop():
    return jessentials.get_environment_variable("XDG_CURRENT_DESKTOP")

def getLanguage():
    return jessentials.get_environment_variable("LANG").split("_")[0]

def getDefaultBrowser():
    lines = jessentials.run_command("xdg-settings get default-web-browser", False, True)
    return lines[0].replace(".desktop", "")

def getSessionType():
    return jessentials.get_environment_variable("XDG_SESSION_TYPE")


print(f"{getDistribution()}\n{getVersionId()}\n{getDesktop()}\n{getLanguage()}\n{getDefaultBrowser()}\n{getSessionType()}")
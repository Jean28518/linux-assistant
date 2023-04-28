# Build instructions
## Prerequisites
- flatpak-builder
- org.freedesktop.Platform (Flathub)
- org.freedesktop.Sdk (Flathub)

Install runtime and SDK with:<br>
`flatpak install flathub org.freedesktop.Platform//22.08 org.freedesktop.Sdk//22.08`

## Build and install
Build the application:<br>
`flatpak-builder --force-clean build-dir org.linuxassistant.desktop.yaml`


Install the application:<br>
`flatpak-builder --user --install --force-clean build-dir org.linuxassistant.desktop.yaml`

## Post-install
Change the `getDefaultBrowser` function in the file 'build-dir/files/linux-assistant/additional/python/get_environment.py' from:
```
def getDefaultBrowser():
    lines = jessentials.run_command("xdg-settings get default-web-browser", False, True)
    return lines[0].replace(".desktop", "")
```
to:
```
def getDefaultBrowser():
    lines = jessentials.run_command("/run/host/usr/bin/xdg-settings get default-web-browser", False, True)
    if len(lines) > 0:
        return lines[0].replace(".desktop", "")
    else:
        return ""
```

Now you can run the application with the command:<br>
`flatpak run org.linuxassistant.desktop`


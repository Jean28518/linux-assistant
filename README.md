# linux-assistant
Distribution indenpendent tool for everything, a linux desktop user needs. Written in flutter

## Requirements
```bash
sudo apt install keybinder-3.0 
sudo apt install libkeybinder-3.0-0 libkeybinder-3.0-dev # For debian 11, Ubuntu 22.04, ...

sudo apt install wmctrl
```

## Build
```bash
# Install keybinder, see requirements
sudo rm /etc/apt/preferences.d/nosnap.pref # (For Linux Mint)
sudo apt install snapd git
sudo snap install flutter --classic
flutter doctor # If command not found: Reboot and try again
git clone https://github.com/Jean28518/linux-assistant.git
cd linux-assistant
flutter build linux
cp -r additional build/linux/x64/release/bundle/

# Build and install .deb package:
bash ./build-deb.sh
sudo dpkg --install linux-assistant.deb

# Or altnertively run manually: 
cd build/linux/x64/release/bundle/
./linux_assistant
```

## Features
| Feature                   | Debian | Ubuntu | Linux Mint | PopOS | MX Linux | Gnome | Xfce | Cinnamon | Notes |
| ------------------------- | ------ | ------ | ---------- | ----- | -------- | ----- | ---- | -------- | ----- |
| App Search                | :V:    | :v:    | :v:        | :v:   | :v:      | :v:   | :v:  | :v:      |       |
| File Search               | :v:    | :v:    | :v:        | :v:   | :v:      | :v:   | :v:  | :v:      |       |

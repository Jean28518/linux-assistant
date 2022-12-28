# linux-assistant
Distribution indenpendent tool for everything, a linux desktop user needs. Written in flutter

## Requirements
```bash
sudo apt install keybinder-3.0 
sudo apt install libkeybinder-3.0-0 libkeybinder-3.0-dev # For debian 11, Ubuntu 22.04, ...

sudo apt install wmctrl
```

## Build for Debian based distros
```bash
# Install keybinder, see requirements
sudo rm /etc/apt/preferences.d/nosnap.pref # (For Linux Mint)
sudo apt install snapd git
sudo snap install flutter --classic
flutter doctor # If command not found: Reboot and try again
git clone https://github.com/Jean28518/linux-assistant.git
cd linux-assistant

# Option 1: Build with flutter manually
flutter build linux
chmod +x additional/python/run_script.py
cp -r additional build/linux/x64/release/bundle/
cd build/linux/x64/release/bundle/
./linux_assistant

# Option 2: Build .deb and install .deb package:
bash ./build-deb.sh
sudo dpkg --install linux-assistant.deb

```

### Build for Arch based distros
<!--- Move to Wiki --->
```bash
# Requirements:
sudo pacman -S libkeybinder3
install flutter #(The way what do you want)
git clone https://github.com/Jean28518/linux-assistant.git
cd linux-assistant

# Option 1: Option 1 for Debian based distros

# Option 2: Build and install package:
bash ./build-arch.sh
cd arch && makepkg -si
```

## Features
Check the `features.csv` file for detailed features.

## Current Languages:
- English
- German

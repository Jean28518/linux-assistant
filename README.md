# linux-assistant
Distribution indenpendent tool for everything, a linux desktop user needs. Written in flutter

## Requirements
```bash
sudo apt install keybinder-3.0
sudo apt install gir1.2-keybinder-3.0 # For debian
```

## Build
```bash
# Install keybinder, see requirements
sudo apt install snapd
sudo snap install flutter --classic
flutter doctor # If command not found: Reboot and try again
flutter build linux
cp -r additional build/linux/x64/release/bundle/
```

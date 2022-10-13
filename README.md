# linux-assistant
Distribution indenpendent tool for everything, a linux desktop user needs. Written in flutter

## Requirements
```bash
sudo apt-get install keybinder-3.0
```

## Build
```bash
sudo apt-get install keybinder-3.0 snapd
sudo snap install flutter --classic
flutter doctor # If command not found: Reboot and try again
flutter build linux
cp -r additional build/linux/x64/release/bundle/
```

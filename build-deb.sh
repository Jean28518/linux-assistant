#!/bin/bash
VERSION="$( cat version )"

# Remove files from previous build
sudo rm -r deb/usr/

# Build Linux Assistant
chmod +x additional/python/run_script.py
flutter build linux
cp -r additional build/linux/x64/release/bundle/
cp version build/linux/x64/release/bundle/

# Prepare deb files for packaging
mkdir -p deb/usr/lib/linux-assistant/
cp -r build/linux/x64/release/bundle/* deb/usr/lib/linux-assistant/
mkdir -p deb/usr/share/icons/hicolor/scalable/apps/
cp linux-assistant.svg deb/usr/share/icons/hicolor/scalable/apps/
mkdir -p deb/usr/share/icons/hicolor/256x256/apps/
cp linux-assistant.png deb/usr/share/icons/hicolor/256x256/apps/
mkdir -p deb/usr/share/applications/
cp linux-assistant.desktop deb/usr/share/applications/
mkdir -p deb/usr/share/polkit-1/actions/
cp org.linux-assistant.operations.policy deb/usr/share/polkit-1/actions/
mkdir -p deb/usr/bin/
cp linux-assistant.sh deb/usr/bin/linux-assistant

# chmod and chown
sudo chown -R root:root deb/
sudo chmod -R 755 deb/
sudo chmod +x deb/usr/bin/linux-assistant

# Build deb package
sed -i "2s/.*/Version: $VERSION/" deb/DEBIAN/control
dpkg-deb --build -Zxz deb 
mv deb.deb linux-assistant.deb

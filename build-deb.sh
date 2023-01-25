#!/bin/bash
VERSION=0.1.5

chmod +x additional/python/run_script.py
flutter build linux
cp -r additional build/linux/x64/release/bundle/
cp -r build/linux/x64/release/bundle/* deb/usr/lib/linux-assistant/
mkdir -p deb/usr/bin/
cp linux-assistant deb/usr/bin/
chmod +x deb/usr/bin/linux-assistant
chmod 755 deb/DEBIAN
sed -i "2s/.*/Version: $VERSION/" deb/DEBIAN/control
dpkg-deb --build -Zxz deb 
mv deb.deb linux-assistant.deb
#!/bin/bash
chmod +x additional/python/run_script.py
flutter build linux
cp -r additional build/linux/x64/release/bundle/
cp -r build/linux/x64/release/bundle/* deb/usr/lib/linux-assistant/
chmod +x deb/usr/bin/linux-assistant
chmod 755 deb/DEBIAN
dpkg-deb --build -Zxz deb 
mv deb.deb linux-assistant.deb

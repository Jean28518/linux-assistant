#!/bin/bash
cp -r build/linux/x64/release/bundle/* deb/usr/lib/linux-assistant/
chmod +x deb/usr/bin/linux-assistant
chmod 755 deb/DEBIAN
dpkg-deb --build deb 
mv deb.deb linux-assistant.deb

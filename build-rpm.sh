#!/bin/bash
VERSION=0.2.2

# Build Linux Assistant
chmod +x additional/python/run_script.py
flutter build linux
cp -r additional build/linux/x64/release/bundle/

# Prepare rpm files for packaging
mkdir -p rpmbuild/SOURCES/linux-assistant-$VERSION
cp -r build/linux/x64/release/bundle/* rpmbuild/SOURCES/linux-assistant-$VERSION/
cp linux-assistant rpmbuild/SOURCES/linux-assistant-$VERSION/
chmod +x rpmbuild/SOURCES/linux-assistant-$VERSION/linux-assistant
cp linux_assistant.desktop rpmbuild/SOURCES/linux-assistant-$VERSION/
cp linux-assistant.svg rpmbuild/SOURCES/linux-assistant-$VERSION/
cp linux-assistant.png rpmbuild/SOURCES/linux-assistant-$VERSION/
cp org.linux-assistant.operations.policy rpmbuild/SOURCES/linux-assistant-$VERSION/

# Package rpm files and build
cd rpmbuild/SOURCES/
tar -czvf linux-assistant-$VERSION.tar.gz linux-assistant-$VERSION
cd ../../
cp -r rpmbuild $HOME/
sed -i "2s/.*/Version:        $VERSION/" ./rpmbuild/SPECS/linux-assistant.spec 
rpmbuild -ba ./rpmbuild/SPECS/linux-assistant.spec 
echo "Your rpm package is now at $HOME/rpmbuild/RPMS/"
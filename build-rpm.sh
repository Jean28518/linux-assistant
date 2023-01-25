#!/bin/bash
VERSION=0.1.5

chmod +x additional/python/run_script.py
flutter build linux
cp -r additional build/linux/x64/release/bundle/

mkdir -p rpmbuild/SOURCES/linux-assistant-$VERSION
cp -r build/linux/x64/release/bundle/* rpmbuild/SOURCES/linux-assistant-$VERSION/
cp linux-assistant rpmbuild/SOURCES/linux-assistant-$VERSION/
chmod +x rpmbuild/SOURCES/linux-assistant-$VERSION/linux-assistant
cd rpmbuild/SOURCES/
tar -czvf linux-assistant-$VERSION.tar.gz linux-assistant-$VERSION
cd ../../
cp -r rpmbuild $HOME/
sed -i "2s/.*/Version:        $VERSION/" ./rpmbuild/SPECS/linux-assistant.spec 
rpmbuild -ba ./rpmbuild/SPECS/linux-assistant.spec 
echo "Your rpm package is now at $HOME/rpmbuild/RPMS/"
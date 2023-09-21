# Build App
flutter build linux
# Add additional files to bundle
cp -r additional build/linux/x64/release/bundle/
chmod +x build/linux/x64/release/bundle/linux-assistant

# Delete old bundle if present
if [ -d "linux-assistant-bundle" ]; then
    rm -r linux-assistant-bundle
fi

mkdir -p linux-assistant-bundle
# Copy relevant files to zip
cp -r build/linux/x64/release/bundle/* linux-assistant-bundle/
cp linux-assistant.sh linux-assistant-bundle/
cp linux-assistant.png linux-assistant-bundle/
cp -r flatpak linux-assistant-bundle/
cp version linux-assistant-bundle/

# Get libkeybinder.so
cp /lib/x86_64-linux-gnu/libkeybinder-3.0.so.0 linux-assistant-bundle/lib/

# Delete old zip if present
if [ -f "linux-assistant-bundle.zip" ]; then
    rm linux-assistant-bundle.zip
fi
zip -r linux-assistant-bundle.zip linux-assistant-bundle
sha256sum linux-assistant-bundle.zip
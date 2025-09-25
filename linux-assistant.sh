#!/bin/bash

APP_DIR="" # leave it empty

# if the application is running as a Snap
# snap applications are installed in /snap/<appname>/<version> and the script is in bin
# so the lib dir is at $SNAP/bin/lib
# unset some variables to prevent conflicts
if [ -n "$SNAP" ]; then
    APP_DIR="$SNAP/bin/lib"
    # disable some variables
    unset LD_LIBRARY_PATH
    unset XDG_DATA_DIRS
    unset GTK_PATH
    unset GSETTINGS_SCHEMA_DIR
    unset GI_TYPELIB_PATH
    unset GIO_EXTRA_MODULES
    unset GTK_USE_PORTAL
    unset GDK_DISABLE_MEDIA
    echo "[LA] Using snap"
    
# running as LA as flatpak
elif [ -d "/app/bin" ]; then
    APP_DIR="/app/bin"
    echo "[LA] Using flatpak"
    
# running LA local
elif [ -f "linux-assistant" ]; then
    APP_DIR="."
    echo "[LA] Using local"
else
    # use /usr/lib as fallback 
    APP_DIR="/usr/lib/linux-assistant"
    echo "[LA] Using standard installation"
fi

echo "[LA] App_DIR: $APP_DIR"

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
  VERSION=""
  if [ -f "$APP_DIR/version" ]; then
    VERSION=$( cat "$APP_DIR/version" )
  fi
  echo ""
  echo "Linux-Assistant $VERSION"
  echo "A daily linux helper with powerful integrated search, routines and checks."
  echo "Homepage: https://www.linux-assistant.org"
  exit 0
fi

if wmctrl -l | grep -q 'Linux Assistant'; then
  wmctrl -a 'Linux Assistant'
else
  "$APP_DIR/linux-assistant"
fi

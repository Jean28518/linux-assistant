#!/bin/bash
APP_DIR="/usr/lib/linux-assistant"

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
  VERSION=""
  if [ -f "$APP_DIR/version" ]; then
    VERSION=$( cat "$APP_DIR/version" )
  fi

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

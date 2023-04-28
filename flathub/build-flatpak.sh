#!/usr/bin/env bash
set -e
set -x

project="linux-assistant"

mkdir -p /app
cp -r $project /app/

mkdir -p /app/$project/additional
mv /app/$project/python /app/$project/logos /app/$project/additional

mkdir -p /app/$project/data
mv /app/$project/icudtl.dat /app/$project/flutter_assets /app/$project/data/

mkdir -p /app/$project/lib
mv /app/$project/*.so /app/$project/lib/

mkdir -p /app/bin
chmod +x /app/linux-assistant/linux_assistant
ln -s /app/linux-assistant/linux_assistant /app/bin/linux-assistant

#!/bin/bash

export MIX_ENV=prod
export PORT=4790
export HOME=/home/ethan/hw03/
echo "Stopping old copy of app, if any..."

/home/ethan/hw03/_build/prod/rel/practice/bin/practice stop || true

echo "Starting app..."

/home/ethan/hw03/_build/prod/rel/practice/bin/practice start

# DONE: Change "foreground" to "Start"

# DONE: Add a cron rule or systemd service file
#       to start your app on system boot.


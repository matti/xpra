#!/usr/bin/env sh

set -e

echo "lol"

xpra start --bind-tcp=0.0.0.0:14500 --html=on --start=xterm
sleep 1
tail -f /tmp/*.log
tail -f /root/.xpra/*
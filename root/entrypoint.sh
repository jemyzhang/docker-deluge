#!/bin/sh

chown -R debian-deluged:debian-deluged /var/lib/deluged
service deluged start
service deluge-web start
sleep 10
tail -f /var/log/deluged/web.log

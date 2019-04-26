#!/bin/sh

# this launcher script tails the access and error logs
# to the stdout and stderr, so that `docker logs -f lighthttpd` works.

tail -F /var/log/lighttpd/access.log 2>/dev/null >/dev/stdout &
tail -F /var/log/lighttpd/error.log 2>/dev/null >/dev/stderr &
lighttpd -f /etc/lighttpd/lighttpd.conf
/dump1090/dump1090 --net --ppm 0 --fix --max-range 300 --net-ri-port 30001 --net-ro-port 30002 --net-bi-port 30004,30104 --net-bo-port 30005 --net-sbs-port 30003 --net-heartbeat 60 --net-ro-size 500 --net-ro-interval 1 --net-buffer 2 --stats-every 3600 --write-json /run/dump1090-fa --write-json-every 1 --json-location-accuracy 1 --quiet

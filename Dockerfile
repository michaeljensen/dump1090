# docker build -t dump1090 .
# docker run --device=/dev/bus/usb -p 8080:8080 -p 8888:80 -p 30003:30003 dump1090-fa
# then connect to http://localhost:8888

FROM debian:stretch-slim

MAINTAINER michaeljensen version: 1.0

RUN apt-get update && apt-get install -y git libncurses5-dev librtlsdr-dev make pkg-config build-essential lighttpd

COPY . /dump1090/
RUN cd /dump1090 && make BLADERF=no

RUN mkdir /usr/share/dump1090-fa && cp -a /dump1090/public_html /usr/share/dump1090-fa/html && cp -a /dump1090/debian/lighttpd/89-dump1090-fa.conf /etc/lighttpd/conf-enabled/89-dump1090-fa.conf  
RUN mkdir -p /run/dump1090-fa

COPY dockerstart.sh /usr/local/bin/
CMD ["dockerstart.sh"]


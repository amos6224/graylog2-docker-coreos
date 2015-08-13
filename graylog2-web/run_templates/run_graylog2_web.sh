#!/bin/bash

GRAYLOG_SERVERS=${GRAYLOG_SERVERS:-graylog2-server.skydns.local:12900}
GRAYLOG_SERVER_SECRET=${GRAYLOG_SERVER_SECRET:-$(pwgen -s 96)}

sed -i "s@GRAYLOG_SERVERS@$GRAYLOG_SERVERS@" /graylog2-web/conf/graylog-web-interface.conf
sed -i "s/GRAYLOG_SERVER_SECRET/$GRAYLOG_SERVER_SECRET/"  /graylog2-web/conf/graylog-web-interface.conf

/graylog2-web/bin/graylog-web-interface

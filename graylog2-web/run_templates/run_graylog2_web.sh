#!/bin/bash

ME=`basename "$0"`

GRAYLOG_SERVERS=${GRAYLOG_SERVERS:-"http://graylog2-server.skydns.local:12900"}
GRAYLOG_SERVER_SECRET=${GRAYLOG_SERVER_SECRET:-$(pwgen -s 96)}
GRAYLOG_TIMEZONE=${GRAYLOG_TIMEZONE:-"Europe/London"}

echo "$ME: Graylog servers: $GRAYLOG_SERVERS"
echo "$ME: Graylog Timezone: $GRAYLOG_TIMEZONE"

CONFIG_FILE=/graylog2-web/conf/graylog-web-interface.conf

sed -i "s@GRAYLOG_SERVERS@$GRAYLOG_SERVERS@" $CONFIG_FILE
sed -i "s/GRAYLOG_SERVER_SECRET/$GRAYLOG_SERVER_SECRET/"  $CONFIG_FILE
sed -i "s@GRAYLOG_TIMEZONE@$GRAYLOG_TIMEZONE@" $CONFIG_FILE

if [ -z ${GRAYLOG_PREFIX+x} ];
	then 
		echo "$ME: Leaving application.context to default";
	else 
		echo "$ME: Setting application context to $GRAYLOG_PREFIX"; 
		sed -i "s@#application.context=@application.context=$GRAYLOG_PREFIX@" $CONFIG_FILE
fi


/graylog2-web/bin/graylog-web-interface

#!/bin/bash

set -e

# defaults
ES_HOSTS=${ES_HOSTS:-elasticsearch.skydns.local}
ES_NODE_NAME=${ES_NODE_NAME:-graylog2-server}
MONGODB_SERVERS=${MONGODB_SERVERS:-mongo.skydns.local}
MONGODB_RSET=${MONGODB_RSET:-graylog}
#MONGODB_PORT=${MONGODB_PORT:-27017}
#HOST_IP=${COREOS_INTERNAL_IPV4}
GRAYLOG_PASSWORD=${GRAYLOG_PASSWORD:-e3c652f0ba0b4801205814f8b6bc49672c4c74e25b497770bb89b22cdeb4e951}
GRAYLOG_SERVER_SECRET=${GRAYLOG_SERVER_SECRET:-$(pwgen -s 96)}

# replace in config file
sed -i "s/ES_HOSTS/$ES_HOSTS/" /etc/graylog2.conf
sed -i "s/ES_NODE_NAME/$ES_NODE_NAME/" /etc/graylog2.conf
sed -i "s/MONGODB_SERVERS/$MONGODB_SERVERS/" /etc/graylog2.conf
sed -i "s/MONGODB_RSET/$MONGODB_RSET/" /etc/graylog2.conf
#sed -i "s/MONGODB_PORT/$MONGODB_PORT/" /etc/graylog2.conf
#sed -i "s/HOST_IP/$HOST_IP/" /etc/graylog2.conf
sed -i "s/GRAYLOG_PASSWORD/$GRAYLOG_PASSWORD/" /etc/graylog2.conf
sed -i "s/GRAYLOG_SERVER_SECRET/$GRAYLOG_SERVER_SECRET/" /etc/graylog2.conf

export GRAYLOG_CONF=/etc/graylog2.conf
/graylog2/bin/graylogctl run

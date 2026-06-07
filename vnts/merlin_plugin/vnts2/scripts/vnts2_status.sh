#!/bin/sh
source /koolshare/scripts/base.sh

pid=`pidof vnts2`
if [ -n "$pid" ]; then
    http_response "【vnts2】 - 服务运行正常 (PID: $pid)"
else
    http_response "【vnts2】 - 服务未运行"
fi

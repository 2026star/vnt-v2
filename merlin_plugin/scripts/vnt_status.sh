#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
vnt_path=`dbus get vnt_path`
[ -z "$vnt_path" ] && vnt_path=/koolshare/bin/vnt2_cli
vnt_pid=`pidof vnt2_cli`
if [ -n "$vnt_pid" ];then
	cliver=`$vnt_path --version 2>/dev/null | head -n 1 | awk '{print $2}'`
	[ -z "$cliver" ] && cliver=`$vnt_path -V 2>/dev/null | head -n 1 | awk '{print $2}'`
	[ -z "$cliver" ] && cliver=`dbus get vntcli_version`
	[ ! -z "$cliver" ] && cliver=`echo "$cliver" | sed 's/^2\.0\.[0-9]\+/2.0/'`
	[ ! -z "$cliver" ] && cliver="vnt $cliver"
	vntcli_log="$cliver <span style='color:  #7FFF00'>运行中<img src='https://www.right.com.cn/forum/data/attachment/album/202401/30/081238k459q2d5klacs8rk.gif' width='30px' alt=''> PID：$vnt_pid </span>"
else
	vntcli_log="<span style='color:  #FF0000'>未运行</span>"
fi

vnts_path=`dbus get vnts_path`
[ -z "$vnts_path" ] && vnts_path=/koolshare/bin/vnts2
vnts_pid=`pidof vnts2`
if [ -n "$vnts_pid" ];then
	sver=`$vnts_path --version 2>/dev/null | head -n 1 | awk '{print $2}'`
	[ -z "$sver" ] && sver=`$vnts_path -V 2>/dev/null | head -n 1 | awk '{print $2}'`
	[ -z "$sver" ] && sver=`dbus get vnts_version`
	[ ! -z "$sver" ] && sver=`echo "$sver" | sed 's/^2\.0\.[0-9]\+/2.0/'`
	[ ! -z "$sver" ] && sver="vnts $sver"
	vnts_log="$sver <span style='color:  #7FFF00'>运行中<img src='https://www.right.com.cn/forum/data/attachment/album/202401/30/081238k459q2d5klacs8rk.gif' width='30px' alt=''> PID：$vnts_pid </span>"
else
	vnts_log="<span style='color:  #FF0000'>未运行</span>"
fi
http_response "$vntcli_log | $vnts_log"

#!/bin/sh

source /koolshare/scripts/base.sh
eval `dbus export vnt_`
eval `dbus export vnts_`
eval `dbus export vnts2_`
mkdir -p /tmp/upload
mkdir -p /home/root/log
touch /home/root/log/vnt2_cli.log
touch /home/root/log/vnts2.log
vnt_log=/home/root/log/vnt2_cli.log
vnts_log=/home/root/log/vnts2.log

vnt_enable=`dbus get vnt_enable`
vnts_enable=`dbus get vnts_enable`
vnt_wg_enable=`dbus get vnt_wg_enable`
vnt_proxy_enable=`dbus get vnt_proxy_enable`
vnt_W_enable=`dbus get vnt_W_enable`
vnt_finger_enable=`dbus get vnt_finger_enable`
vnt_relay_enable=`dbus get vnt_relay_enable`
vnt_first_latency_enable=`dbus get vnt_first_latency_enable`
vnt_tun_name=`dbus get vnt_tun_name`
vnts_finger_enable=`dbus get vnts_finger_enable`
vnt_cron_time=`dbus get vnt_cron_time`
vnt_cron_hour_min=`dbus get vnt_cron_hour_min`
vnts_cron_time=`dbus get vnts_cron_time`
vnts_cron_hour_min=`dbus get vnts_cron_hour_min`
vnt_local_dev=`dbus get vnt_local_dev`
vnt_token=`dbus get vnt_token`
vnt_compressor=`dbus get vnt_compressor`
vnt_mapping=`dbus get vnt_mapping`
vnts_token=`dbus get vnts_token`
vnt_ipmode=`dbus get vnt_ipmode`
vnt_static_ip=`dbus get vnt_static_ip`
vnt_desvice_id=`dbus get vnt_desvice_id`
vnt_desvice_name=`dbus get vnt_desvice_name`
vnt_localadd=`dbus get vnt_localadd`
vnt_peeradd=`dbus get vnt_peeradd`
vnt_serveraddr=`dbus get vnt_serveraddr`
vnt_stunaddr=`dbus get vnt_stunaddr`
vnt_ipv4_mode=`dbus get vnt_ipv4_mode`
vnt_cron_type=`dbus get vnt_cron_type`
vnts_cron_type=`dbus get vnts_cron_type`
vnt_port=`dbus get vnt_port`
vnts_port=`dbus get vnts_port`
vnt_mtu=`dbus get vnt_mtu`
vnt_passmode=`dbus get vnt_passmode`
vnt_key=`dbus get vnt_key`
vnt_path=`dbus get vnt_path`
vnts_path=`dbus get vnts_path`
vnts_mask=`dbus get vnts_mask`
vnts_gateway=`dbus get vnts_gateway`
vnts_web=`dbus get vnts_web_enable`
vnts_web_port=`dbus get vnts_web_port`
vnts_web_pass=`dbus get vnts_web_pass`
vnts_web_user=`dbus get vnts_web_user`
vnts_web_wan=`dbus get vnts_web_wan`
user_agent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36'
lanaddr=$(ifconfig br0|grep -Eo "inet addr.+"|awk -F ":| " '{print $3}' 2>/dev/null)
if [ -z "$vnt_path" ] ; then
   JFFS_AVAIL=$(df | grep -w "/jffs$" | awk '{print $4}')
   if [ "${JFFS_AVAIL}" -lt "4096" ];then
       vnt_path=/tmp/var/vnt2_cli
      dbus set vnt_path=$vnt_path
   else
      vnt_path=/koolshare/bin/vnt2_cli
      dbus set vnt_path=$vnt_path
   fi
fi
if [ -z "$vnts_path" ] ; then
   JFFS_AVAIL=$(df | grep -w "/jffs$" | awk '{print $4}')
   if [ "${JFFS_AVAIL}" -lt "5084" ];then
       vnts_path=/tmp/var/vnts2
      dbus set vnts_path=$vnts_path
   else
      vnts_path=/koolshare/bin/vnts2
      dbus set vnts_path=$vnts_path
   fi
fi
cputype=$(uname -ms | tr ' ' '_' | tr '[A-Z]' '[a-z]')
[ -n "$(echo $cputype | grep -E "linux.*armv.*")" ] && cpucore="arm"
[ -n "$(echo $cputype | grep -E "linux.*armv7.*")" ] && [ -n "$(cat /proc/cpuinfo | grep vfp)" ] && cpucore="armv7"
[ -n "$(echo $cputype | grep -E "linux.*aarch64.*|linux.*armv8.*")" ] && cpucore="aarch64"
scriptname=$(basename $0)
proxy_url="https://hub.gitmirror.com/"
proxy_url2="http://gh.ddlc.top/"
# 时间同步
fun_ntp_sync(){
    ntp_server=`nvram get ntp_server0`
    start_time="`date +%Y%m%d`"
    ntpclient -h ${ntp_server} -i3 -l -s > /dev/null 2>&1
    if [ "${start_time}"x = "`date +%Y%m%d`"x ]; then
        ntpclient -h ntp1.aliyun.com -i3 -l -s > /dev/null 2>&1
    fi
}

logg () {
   #logger -t "【vnt】" "$1"
   echo -e "\033[36;1m【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】: \033[0m\033[35;1m$1 \033[0m"
   if [ "$2" = "vnt-cli" ] ; then
   echo "【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】: $1 " >>$vnt_log
   fi
   if [ "$2" = "vnts" ] ; then
   echo "【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】: $1 " >>$vnts_log
   fi
}

# 自启
fun_nat_start(){
    if [ "${vnt_enable}"x = "1"x ] || [ "${vnts_enable}"x = "1"x ];then
	    [ ! -L "/koolshare/init.d/S49vnt.sh" ] && ln -sf /koolshare/scripts/vnt_config.sh /koolshare/init.d/S49vnt.sh
            #[ ! -L "/koolshare/init.d/N49vnt.sh" ] && ln -sf /koolshare/scripts/vnt_config.sh /koolshare/init.d/N49vnt.sh
	    #如果开机自启失败，试着去掉上方代码前的 # 号
    fi
}
# 定时任务
fun_crontab(){
    if [ "${vnt_enable}" != "1" ] || [ "${vnt_cron_time}"x = "0"x ];then
        [ -n "$(cru l | grep vnt_monitor)" ] && cru d vnt_monitor
    fi
    if [ "${vnts_enable}" != "1" ] || [ "${vnts_cron_time}"x = "0"x ];then
        [ -n "$(cru l | grep vnts_monitor)" ] && cru d vnts_monitor
    fi
     if [ "${vnt_cron_hour_min}" == "min" ] && [ "${vnt_cron_time}"x != "0"x ] ; then
        if [ "${vnt_cron_type}" == "watch" ]; then
        	cru a vnt_monitor "*/"${vnt_cron_time}" * * * * /bin/sh /koolshare/scripts/vnt_config.sh watchvnt"
        elif [ "${vnt_cron_type}" == "start" ]; then
            cru a vnt_monitor "*/"${vnt_cron_time}" * * * * /bin/sh /koolshare/scripts/vnt_config.sh restartvnt"
    	fi
    elif [ "${vnt_cron_hour_min}" == "hour" ] && [ "${vnt_cron_time}"x != "0"x ] ; then
        if [ "${vnt_cron_type}" == "watch" ]; then
            cru a vnt_monitor "0 */"${vnt_cron_time}" * * * /bin/sh /koolshare/scripts/vnt_config.sh watchvnt"
        elif [ "${vnt_cron_type}" == "start" ]; then
            cru a vnt_monitor "0 */"${vnt_cron_time}" * * * /bin/sh /koolshare/scripts/vnt_config.sh restartvnt"
        fi
    fi
      if [ "${vnts_cron_hour_min}" == "min" ] && [ "${vnts_cron_time}"x != "0"x ] ; then
        if [ "${vnts_cron_type}" == "watch" ]; then
        	cru a vnts_monitor "*/"${vnts_cron_time}" * * * * /bin/sh /koolshare/scripts/vnt_config.sh watchvnts"
        elif [ "${vnts_cron_type}" == "start" ]; then
            cru a vnts_monitor "*/"${vnts_cron_time}" * * * * /bin/sh /koolshare/scripts/vnt_config.sh restartvnts"
    	fi
    elif [ "${vnts_cron_hour_min}" == "hour" ] && [ "${vnts_cron_time}"x != "0"x ] ; then
        if [ "${vnts_cron_type}" == "watch" ]; then
            cru a vnts_monitor "0 */"${vnts_cron_time}" * * * /bin/sh /koolshare/scripts/vnt_config.sh watchvnts"
        elif [ "${vnts_cron_type}" == "start" ]; then
            cru a vnts_monitor "0 */"${vnts_cron_time}" * * * /bin/sh /koolshare/scripts/vnt_config.sh restartvnts"
        fi
    fi
}

# 关闭进程（先用默认信号，再使用9）
open_server_ports(){
    vnts2_tcp_port=$(echo "$vnts2_tcp_bind" | cut -d':' -f2)
    [ -z "$vnts2_tcp_port" ] && vnts2_tcp_port=29872

    vnts2_quic_port=$(echo "$vnts2_quic_bind" | cut -d':' -f2)
    [ -z "$vnts2_quic_port" ] && vnts2_quic_port=29872

    vnts2_ws_port=$(echo "$vnts2_ws_bind" | cut -d':' -f2)
    [ -z "$vnts2_ws_port" ] && vnts2_ws_port=29872

    iptables -I INPUT -p tcp --dport $vnts2_tcp_port -j ACCEPT 2>/dev/null
    ip6tables -I INPUT -p tcp --dport $vnts2_tcp_port -j ACCEPT 2>/dev/null
    iptables -I OUTPUT -p tcp --dport $vnts2_tcp_port -j ACCEPT 2>/dev/null
    ip6tables -I OUTPUT -p tcp --dport $vnts2_tcp_port -j ACCEPT 2>/dev/null

    iptables -I INPUT -p udp --dport $vnts2_quic_port -j ACCEPT 2>/dev/null
    ip6tables -I INPUT -p udp --dport $vnts2_quic_port -j ACCEPT 2>/dev/null
    iptables -I OUTPUT -p udp --dport $vnts2_quic_port -j ACCEPT 2>/dev/null
    ip6tables -I OUTPUT -p udp --dport $vnts2_quic_port -j ACCEPT 2>/dev/null

    if [ "$vnts2_ws_port" != "$vnts2_tcp_port" ]; then
        iptables -I INPUT -p tcp --dport $vnts2_ws_port -j ACCEPT 2>/dev/null
        ip6tables -I INPUT -p tcp --dport $vnts2_ws_port -j ACCEPT 2>/dev/null
        iptables -I OUTPUT -p tcp --dport $vnts2_ws_port -j ACCEPT 2>/dev/null
        ip6tables -I OUTPUT -p tcp --dport $vnts2_ws_port -j ACCEPT 2>/dev/null
    fi

    if [ -n "$vnts2_web_bind" ]; then
        vnts2_web_port=$(echo "$vnts2_web_bind" | cut -d':' -f2)
        [ -z "$vnts2_web_port" ] && vnts2_web_port=29871
        iptables -I INPUT -p tcp --dport $vnts2_web_port -j ACCEPT 2>/dev/null
        ip6tables -I INPUT -p tcp --dport $vnts2_web_port -j ACCEPT 2>/dev/null
        iptables -I OUTPUT -p tcp --dport $vnts2_web_port -j ACCEPT 2>/dev/null
        ip6tables -I OUTPUT -p tcp --dport $vnts2_web_port -j ACCEPT 2>/dev/null
    fi

    [ -z "$(cru l | grep vnts_rules)" ] && cru a vnts_rules "*/2 * * * * iptables -C INPUT -p tcp --dport $vnts2_tcp_port -j ACCEPT 2>/dev/null || iptables -I INPUT -p tcp --dport $vnts2_tcp_port -j ACCEPT ; iptables -C INPUT -p udp --dport $vnts2_quic_port -j ACCEPT 2>/dev/null || iptables -I INPUT -p udp --dport $vnts2_quic_port -j ACCEPT ; ip6tables -C INPUT -p tcp --dport $vnts2_tcp_port -j ACCEPT 2>/dev/null || ip6tables -I INPUT -p tcp --dport $vnts2_tcp_port -j ACCEPT ; ip6tables -C INPUT -p udp --dport $vnts2_quic_port -j ACCEPT 2>/dev/null || ip6tables -I INPUT -p udp --dport $vnts2_quic_port -j ACCEPT"
}

onkillvnt(){
    PID=$(pidof vnt2_cli)
    [ -n "$(cru l | grep vnt_monitor)" ] && cru d vnt_monitor
    if [ -n "${PID}" ];then
		kill -9 "${PID}" >/dev/null 2>&1
		killall vnt2_cli >/dev/null 2>&1
    fi
    [ -n "$(cru l | grep vnt_rules)" ] && cru d vnt_rules
    [ -n "$(cru l | grep vnt_rules2)" ] && cru d vnt_rules2
    [ -n "$(cru l | grep vnt_rules3)" ] && cru d vnt_rules3
    if [ ! -z "$vnt_tun_name" ] ; then
       vnt_tunname="${vnt_tun_name}"
    else
       vnt_tunname="vnt-tun"
    fi
   iptables -D INPUT -i ${vnt_tunname} -j ACCEPT 2>/dev/null
   iptables -D FORWARD -i ${vnt_tunname} -o ${vnt_tunname} -j ACCEPT 2>/dev/null
   iptables -D FORWARD -i ${vnt_tunname} -j ACCEPT 2>/dev/null
   iptables -t nat -D POSTROUTING -o ${vnt_tunname} -j MASQUERADE 2>/dev/null
   iptables -D OUTPUT -p tcp -j ACCEPT 2>/dev/null
   ip6tables -D OUTPUT -p tcp -j ACCEPT 2>/dev/null
   [ ! -z "$vnt_static_ip" ] && [ ! -z "$lanaddr" ] && iptables -t nat -D PREROUTING -p tcp -d ${vnt_static_ip} --dport 80 -j DNAT --to-destination ${lanaddr}:80 2>/dev/null
    if [ ! -z "$vnt_port" ] ; then
         if [ ! -z "$(echo $vnt_port | grep ',' )" ] ; then
	     vnt_tcp_port="${vnt_port%%,*}"
	 else
             vnt_tcp_port="$vnt_port"
         fi
	 iptables -D INPUT -p tcp --dport $vnt_tcp_port -j ACCEPT 2>/dev/null
         ip6tables -D INPUT -p tcp --dport $vnt_tcp_port -j ACCEPT 2>/dev/null
    fi
}
onkillvnts(){
    PIDS=$(pidof vnts2)
    [ -n "$(cru l | grep vnts_monitor)" ] && cru d vnts_monitor
    if [ -n "${PIDS}" ];then
		kill -9 "${PIDS}" >/dev/null 2>&1
    fi
    killall -9 vnts2 2>/dev/null
    
    vnts2_tcp_port=$(echo "$vnts2_tcp_bind" | cut -d':' -f2)
    [ -z "$vnts2_tcp_port" ] && vnts2_tcp_port=29872

    vnts2_quic_port=$(echo "$vnts2_quic_bind" | cut -d':' -f2)
    [ -z "$vnts2_quic_port" ] && vnts2_quic_port=29872

    vnts2_ws_port=$(echo "$vnts2_ws_bind" | cut -d':' -f2)
    [ -z "$vnts2_ws_port" ] && vnts2_ws_port=29872

    [ -n "$(cru l | grep vnts_rules)" ] && cru d vnts_rules 
    [ -n "$(cru l | grep vnts_rules2)" ] && cru d vnts_rules2
    [ -n "$(cru l | grep vnts_rules3)" ] && cru d vnts_rules3

    iptables -D INPUT -p tcp --dport $vnts2_tcp_port -j ACCEPT 2>/dev/null
    iptables -D INPUT -p udp --dport $vnts2_quic_port -j ACCEPT 2>/dev/null
    ip6tables -D INPUT -p tcp --dport $vnts2_tcp_port -j ACCEPT 2>/dev/null
    ip6tables -D INPUT -p udp --dport $vnts2_quic_port -j ACCEPT 2>/dev/null
    iptables -D OUTPUT -p tcp --dport $vnts2_tcp_port -j ACCEPT 2>/dev/null
    iptables -D OUTPUT -p udp --dport $vnts2_quic_port -j ACCEPT 2>/dev/null
    ip6tables -D OUTPUT -p tcp --dport $vnts2_tcp_port -j ACCEPT 2>/dev/null
    ip6tables -D OUTPUT -p udp --dport $vnts2_quic_port -j ACCEPT 2>/dev/null

    if [ "$vnts2_ws_port" != "$vnts2_tcp_port" ]; then
        iptables -D INPUT -p tcp --dport $vnts2_ws_port -j ACCEPT 2>/dev/null
        ip6tables -D INPUT -p tcp --dport $vnts2_ws_port -j ACCEPT 2>/dev/null
        iptables -D OUTPUT -p tcp --dport $vnts2_ws_port -j ACCEPT 2>/dev/null
        ip6tables -D OUTPUT -p tcp --dport $vnts2_ws_port -j ACCEPT 2>/dev/null
    fi

    if [ -n "$vnts2_web_bind" ]; then
        vnts2_web_port=$(echo "$vnts2_web_bind" | cut -d':' -f2)
        [ -z "$vnts2_web_port" ] && vnts2_web_port=29871
        iptables -D INPUT -p tcp --dport $vnts2_web_port -j ACCEPT 2>/dev/null
        ip6tables -D INPUT -p tcp --dport $vnts2_web_port -j ACCEPT 2>/dev/null
        iptables -D OUTPUT -p tcp --dport $vnts2_web_port -j ACCEPT 2>/dev/null
        ip6tables -D OUTPUT -p tcp --dport $vnts2_web_port -j ACCEPT 2>/dev/null
    fi
}
# 停止并清理
onstop(){
	onkillvnt
	onkillvnts
	logger "銆愯蒋浠朵腑蹇冦€戯細鍏抽棴 vnt..."
        [ -z "$(pidof vnt2_cli)" ] && logg "瀹㈡埛绔凡鍋滄杩愯" "vnt-cli"
        [ -z "$(pidof vnts2)" ] &&  logg "鏈嶅姟绔凡鍋滄杩愯" "vnts"
}

fun_updatevnt(){
    logg "鎻愮ず锛氳閫氳繃Web椤甸潰鎴朣SH鎵嬪姩涓婁紶骞舵浛鎹?vnt2_cli 瀹㈡埛绔簩杩涘埗鏂囦欢锛? "vnt-cli"
}

fun_updatevnts(){
    logg "鎻愮ず锛氳閫氳繃Web椤甸潰鎴朣SH鎵嬪姩涓婁紶骞舵浛鎹?vnts2 鏈嶅姟绔簩杩涘埗鏂囦欢锛? "vnts"
}

write_client_config(){
    mkdir -p /koolshare/vnt2
    
    servers_toml=""
    if [ -n "$vnt_serveraddr" ]; then
        for s in $(echo "$vnt_serveraddr" | tr '|' ' ' | tr ',' ' '); do
            servers_toml="${servers_toml}\"${s}\", "
        done
        servers_toml=$(echo "$servers_toml" | sed 's/, $//')
    fi
    
    stun_toml=""
    if [ -n "$vnt_stunaddr" ]; then
        for s in $(echo "$vnt_stunaddr" | tr '|' ' ' | tr ',' ' '); do
            stun_toml="${stun_toml}\"${s}\", "
        done
        stun_toml=$(echo "$stun_toml" | sed 's/, $//')
    fi

    input_toml=""
    if [ -n "$vnt_peeradd" ]; then
        for val in $(echo "$vnt_peeradd" | tr '|' ' '); do
            input_toml="${input_toml}\"${val}\", "
        done
        input_toml=$(echo "$input_toml" | sed 's/, $//')
    fi

    output_toml=""
    if [ -n "$vnt_localadd" ]; then
        for val in $(echo "$vnt_localadd" | tr '|' ' '); do
            output_toml="${output_toml}\"${val}\", "
        done
        output_toml=$(echo "$output_toml" | sed 's/, $//')
    fi

    mapping_toml=""
    if [ -n "$vnt_mapping" ]; then
        for val in $(echo "$vnt_mapping" | tr '|' ' '); do
            mapping_toml="${mapping_toml}\"${val}\", "
        done
        mapping_toml=$(echo "$mapping_toml" | sed 's/, $//')
    fi

    no_punch_val="false"
    if [ "$vnt_relay_enable" = "relay" ]; then
        no_punch_val="true"
    fi

    rtx_val="false"
    if [ "$vnt_first_latency_enable" = "1" ]; then
        rtx_val="true"
    fi

    compress_val="false"
    if [ "$vnt_compressor" != "off" ] && [ -n "$vnt_compressor" ]; then
        compress_val="true"
    fi

    fec_val="false"
    if [ "$vnt_fec" = "1" ]; then
        fec_val="true"
    fi

    allow_mapping_val="false"
    if [ "$vnt_allow_mapping" = "1" ]; then
        allow_mapping_val="true"
    fi

    cert_mode_val="skip"
    if [ "$vnt_finger_enable" = "1" ]; then
        cert_mode_val="finger"
    fi

    no_nat_val="false"
    if [ "$vnt_proxy_enable" = "1" ]; then
        no_nat_val="true"
    fi

    cat > /koolshare/vnt2/client_config.toml <<EOF
network_code = "${vnt_token}"
server = [${servers_toml}]
no_punch = ${no_punch_val}
rtx = ${rtx_val}
compress = ${compress_val}
fec = ${fec_val}
allow_mapping = ${allow_mapping_val}
cert_mode = "${cert_mode_val}"
no_nat = ${no_nat_val}
tun_name = "${vnt_tun_name:-vnt-tun}"
ctrl_port = 11233
EOF

    if [ "$vnt_ipmode" = "static" ] && [ -n "$vnt_static_ip" ]; then
        echo "ip = \"${vnt_static_ip}\"" >> /koolshare/vnt2/client_config.toml
    fi
    if [ -n "$vnt_key" ]; then
        echo "password = \"${vnt_key}\"" >> /koolshare/vnt2/client_config.toml
    fi
    if [ -n "$vnt_desvice_id" ]; then
        echo "device_id = \"${vnt_desvice_id}\"" >> /koolshare/vnt2/client_config.toml
    fi
    if [ -n "$vnt_desvice_name" ]; then
        echo "device_name = \"${vnt_desvice_name}\"" >> /koolshare/vnt2/client_config.toml
    fi
    if [ -n "$vnt_mtu" ]; then
        echo "mtu = ${vnt_mtu}" >> /koolshare/vnt2/client_config.toml
    fi
    
    echo "input = [${input_toml}]" >> /koolshare/vnt2/client_config.toml
    echo "output = [${output_toml}]" >> /koolshare/vnt2/client_config.toml
    echo "port_mapping = [${mapping_toml}]" >> /koolshare/vnt2/client_config.toml
    echo "udp_stun = [${stun_toml}]" >> /koolshare/vnt2/client_config.toml
    echo "tcp_stun = [${stun_toml}]" >> /koolshare/vnt2/client_config.toml
}

write_server_config(){
    mkdir -p /koolshare/vnt2
    
    whitelist_toml=""
    if [ -n "$vnts2_whitelist" ]; then
        for val in $(echo "$vnts2_whitelist" | tr '|' ' ' | tr ',' ' ' | tr '\n' ' '); do
            whitelist_toml="${whitelist_toml}\"${val}\", "
        done
        whitelist_toml=$(echo "$whitelist_toml" | sed 's/, $//')
    fi

    peers_toml=""
    if [ -n "$vnts2_peer_servers" ]; then
        for val in $(echo "$vnts2_peer_servers" | tr '|' ' ' | tr ',' ' ' | tr '\n' ' '); do
            peers_toml="${peers_toml}\"${val}\", "
        done
        peers_toml=$(echo "$peers_toml" | sed 's/, $//')
    fi

    persistence_val="true"
    if [ "$vnts2_persistence" = "0" ]; then
        persistence_val="false"
    fi

    cat > /koolshare/vnt2/server_config.toml <<EOF
network = "${vnts2_network:-10.26.0.0/24}"
lease_duration = ${vnts2_lease_duration:-86400}
persistence = ${persistence_val}
white_list = [${whitelist_toml}]
peer_servers = [${peers_toml}]
EOF

    if [ -n "$vnts2_tcp_bind" ]; then
        echo "tcp_bind = \"${vnts2_tcp_bind}\"" >> /koolshare/vnt2/server_config.toml
    fi
    if [ -n "$vnts2_quic_bind" ]; then
        echo "quic_bind = \"${vnts2_quic_bind}\"" >> /koolshare/vnt2/server_config.toml
    fi
    if [ -n "$vnts2_ws_bind" ]; then
        echo "ws_bind = \"${vnts2_ws_bind}\"" >> /koolshare/vnt2/server_config.toml
    fi

    if [ -n "$vnts2_web_bind" ]; then
        echo "web_bind = \"${vnts2_web_bind}\"" >> /koolshare/vnt2/server_config.toml
        echo "username = \"${vnts2_username:-admin}\"" >> /koolshare/vnt2/server_config.toml
        echo "password = \"${vnts2_password:-admin}\"" >> /koolshare/vnt2/server_config.toml
    fi

    if [ -n "$vnts2_cert" ]; then
        echo "cert = \"${vnts2_cert}\"" >> /koolshare/vnt2/server_config.toml
    fi
    if [ -n "$vnts2_key" ]; then
        echo "key = \"${vnts2_key}\"" >> /koolshare/vnt2/server_config.toml
    fi

    if [ -n "$vnts2_token" ]; then
        echo "server_token = \"${vnts2_token}\"" >> /koolshare/vnt2/server_config.toml
    fi
    if [ -n "$vnts2_server_quic_bind" ]; then
        echo "server_quic_bind = \"${vnts2_server_quic_bind}\"" >> /koolshare/vnt2/server_config.toml
    fi

    echo "[custom_nets]" >> /koolshare/vnt2/server_config.toml
    if [ -n "$vnts2_custom_nets" ]; then
        for pair in $(echo "$vnts2_custom_nets" | tr '|' ' ' | tr '\n' ' '); do
            k="${pair%%=*}"
            v="${pair#*=}"
            if [ -n "$k" ] && [ -n "$v" ]; then
                echo "${k} = \"${v}\"" >> /koolshare/vnt2/server_config.toml
            fi
        done
    fi
}

fun_start_vnt(){
     fun_nat_start
     [ -x "${vnt_path}" ] || chmod 755 ${vnt_path}
     
     vntcli_ver=`$vnt_path --version 2>/dev/null | head -n 1 | awk '{print $2}'`
     [ -z "$vntcli_ver" ] && vntcli_ver=`$vnt_path -V 2>/dev/null | head -n 1 | awk '{print $2}'`
     [ -z "$vntcli_ver" ] && vntcli_ver="2.0.0"
     dbus set vntcli_version=$vntcli_ver
     
     logg "寮€濮嬪惎鍔╲nt2_cli_${vntcli_ver}" "vnt-cli"
     write_client_config
     
     if [ "$(lsmod |grep tun |grep -wc tun)" == "0" ]; then
		insmod tun
     fi
     
     mkdir -p /home/root/log
     [ ! -L "/tmp/upload/vnt-cli.log" ] && ln -sf /home/root/log/vnt2_cli.log /tmp/upload/vnt-cli.log
     
     cd /koolshare/vnt2
     killall vnt2_cli 2>/dev/null
     $vnt_path --conf /koolshare/vnt2/client_config.toml >>/home/root/log/vnt2_cli.log 2>&1 &
     
     sleep 5
     if [ -n "$(pidof vnt2_cli)" ]; then
         logg "vnt2_cli_${vntcli_ver}瀹㈡埛绔惎鍔ㄦ垚鍔燂紒" "vnt-cli"
     else
         logg "vnt2_cli_${vntcli_ver}瀹㈡埛绔惎鍔ㄥけ璐ワ紝璇锋鏌ラ厤缃紒" "vnt-cli"
     fi
     echo `date +%s` > /tmp/vnt_time
     
     if [ ! -z "$vnt_tun_name" ] ; then
        vnt_tunname="${vnt_tun_name}"
     else
        vnt_tunname="vnt-tun"
     fi
     iptables -t nat -I POSTROUTING -o ${vnt_tunname} -j MASQUERADE 2>/dev/null
     iptables -I FORWARD -o ${vnt_tunname} -j ACCEPT 2>/dev/null
     iptables -I FORWARD -i ${vnt_tunname} -j ACCEPT 2>/dev/null
     iptables -I INPUT -i ${vnt_tunname} -j ACCEPT 2>/dev/null
     [ ! -z "$vnt_static_ip" ] && [ ! -z "$lanaddr" ] && iptables -t nat -I PREROUTING -p tcp -d ${vnt_static_ip} --dport 80 -j DNAT --to-destination ${lanaddr}:80 2>/dev/null
     [ "$vnt_proxy_enable" = "1" ] && echo 1 > /proc/sys/net/ipv4/ip_forward
     
     [ -z "$(cru l | grep vnt_rules)" ] && cru a vnt_rules "*/2 * * * * test -z \"\$(iptables -L -n -v | grep '$vnt_tunname')\" && /bin/sh /koolshare/scripts/vnt_config.sh restartvnt"
}

fun_start_vnts(){
     fun_nat_start
     [ -x "${vnts_path}" ] || chmod 755 ${vnts_path}
     
     vnts_ver=`$vnts_path --version 2>/dev/null | head -n 1 | awk '{print $2}'`
     [ -z "$vnts_ver" ] && vnts_ver=`$vnts_path -V 2>/dev/null | head -n 1 | awk '{print $2}'`
     [ -z "$vnts_ver" ] && vnts_ver="2.0.0"
     dbus set vnts_version=$vnts_ver
     
     logg "寮€濮嬪惎鍔╲nts2_${vnts_ver}" "vnts"
     write_server_config
     
     mkdir -p /home/root/log
     [ ! -L "/tmp/upload/vnts.log" ] && ln -sf /home/root/log/vnts2.log /tmp/upload/vnts.log
     
     cd /koolshare/vnt2
     killall -9 vnts2 2>/dev/null
     $vnts_path -c /koolshare/vnt2/server_config.toml >>/home/root/log/vnts2.log 2>&1 &
     
     sleep 5
     if [ -n "$(pidof vnts2)" ]; then
         logg "vnts2_${vnts_ver}鏈嶅姟绔惎鍔ㄦ垚鍔燂紒" "vnts"
     else
         logg "vnts2_${vnts_ver}鏈嶅姟绔惎鍔ㄥけ璐ワ紝璇锋鏌ラ厤缃紒" "vnts"
     fi
     echo `date +%s` > /tmp/vnts_time
     
     open_server_ports
}

fun_start_stop(){
 if [ "${vnt_enable}" = "1" ] ; then
  fun_start_vnt
 else
   onkillvnt
 fi
  if [ "${vnts_enable}" = "1" ] ; then
    fun_start_vnts
    else
    onkillvnts
    fi
}

vnt_info(){
 vnt_ctrl_path=$(dirname $vnt_path)/vnt2_ctrl
 [ ! -f "$vnt_ctrl_path" ] && vnt_ctrl_path=/koolshare/bin/vnt2_ctrl
 $vnt_ctrl_path --port 11233 info >/tmp/upload/vnt_info.log 2>&1
}
vnt_all(){
 vnt_ctrl_path=$(dirname $vnt_path)/vnt2_ctrl
 [ ! -f "$vnt_ctrl_path" ] && vnt_ctrl_path=/koolshare/bin/vnt2_ctrl
 $vnt_ctrl_path --port 11233 ips >/tmp/upload/vnt_all.log 2>&1
}
vnt_list(){
  vnt_ctrl_path=$(dirname $vnt_path)/vnt2_ctrl
  [ ! -f "$vnt_ctrl_path" ] && vnt_ctrl_path=/koolshare/bin/vnt2_ctrl
  $vnt_ctrl_path --port 11233 list >/tmp/upload/vnt_list.log 2>&1
}
vnt_route(){
  vnt_ctrl_path=$(dirname $vnt_path)/vnt2_ctrl
  [ ! -f "$vnt_ctrl_path" ] && vnt_ctrl_path=/koolshare/bin/vnt2_ctrl
  $vnt_ctrl_path --port 11233 route >/tmp/upload/vnt_route.log 2>&1
}
vnt_cmds(){
  vntcpu="$(top -b -n1 | grep -E "$(pidof vnt2_cli)" 2>/dev/null| grep -v grep | awk '{for (i=1;i<=NF;i++) {if ($i ~ /vnt2_cli/) break; else cpu=i}} END {print $cpu}')"
  [ ! -z "$vntcpu" ] && echo "vnt2_cli CPU鍗犵敤 ${vntcpu}% " >/tmp/upload/vnt_cmd.log
  vntram="$(cat /proc/$(pidof vnt2_cli | awk '{print $NF}')/status|grep -w VmRSS|awk '{printf "%.2fMB\n", $2/1024}')"
  [ ! -z "$vntram" ] && echo "vnt2_cli 鍐呭瓨鍗犵敤 ${vntram}" >>/tmp/upload/vnt_cmd.log
  vnttime=$(cat /tmp/vnt_time) 
  if [ -n "$vnttime" ] ; then
  time=$(( `date +%s`-vnttime))
  day=$((time/86400))
   [ "$day" = "0" ] && day=''|| day=" $day澶?
   time=`date -u -d @${time} +%H灏忔椂%M鍒?S绉抈
   fi
   [ ! -z "$time" ] && echo "vnt2_cli 宸茶繍琛?$time" >>/tmp/upload/vnt_cmd.log 2>&1
   cmdtart="vnt2_cli --conf /koolshare/vnt2/client_config.toml"
   [ ! -z "$cmdtart" ] && echo "vnt2_cli 鍚姩鍛戒护  $cmdtart" >>/tmp/upload/vnt_cmd.log 2>&1
}
vnts_cmds(){
  vntscpu="$(top -b -n1 | grep -E "$(pidof vnts2)" 2>/dev/null| grep -v grep | awk '{for (i=1;i<=NF;i++) {if ($i ~ /vnts2/) break; else cpu=i}} END {print $cpu}')"
  [ ! -z "$vntscpu" ] && echo "vnts2 CPU鍗犵敤 ${vntscpu}% " >/tmp/upload/vnts_cmd.log
  vntsram="$(cat /proc/$(pidof vnts2 | awk '{print $NF}')/status|grep -w VmRSS|awk '{printf "%.2fMB\n", $2/1024}')"
  [ ! -z "$vntsram" ] && echo "vnts2 鍐呭瓨鍗犵敤 ${vntsram}" >>/tmp/upload/vnts_cmd.log
  vntstime=$(cat /tmp/vnts_time) 
  if [ -n "$vntstime" ] ; then
  time=$(( `date +%s`-vntstime))
  day=$((time/86400))
   [ "$day" = "0" ] && day=''|| day=" $day澶?
   time=`date -u -d @${time} +%H灏忔椂%M鍒?S绉抈
   fi
   [ ! -z "$time" ] && echo "宸茶繍琛?$time" >>/tmp/upload/vnts_cmd.log 2>&1
   cmdstart="vnts2 -c /koolshare/vnt2/server_config.toml"
   [ ! -z "$cmdstart" ] && echo "vnts2 鍚姩鍛戒护  $cmdstart" >>/tmp/upload/vnts_cmd.log 2>&1
}

case $ACTION in
start)

    logger "【软件中心】：启动 vnt..."
	fun_start_stop
	fun_nat_start
	fun_crontab
	;;
stop)
	onstop
	;;
restart)
        onstop
        fun_start_stop
	fun_nat_start
	fun_crontab
	;;
watchvnt)
    [ -n "$(pidof vnt2_cli)" ] && exit
    logger "銆愯蒋浠朵腑蹇冦€戝畾鏃朵换鍔★細杩涚▼鎺夌嚎锛岄噸鏂板惎鍔?vnt..."
    if [ "${vnt_enable}" != "1" ] ; then
   onkillvnt
   exit
   fi
   fun_start_vnt
	;;
watchvnts)
    [ -n "$(pidof vnts2)" ] && exit
    logger "銆愯蒋浠朵腑蹇冦€戝畾鏃朵换鍔★細杩涚▼鎺夌嚎锛岄噸鏂板惎鍔?vnt..."
if [ "${vnts_enable}" != "1" ] ; then
   onkillvnts   
   exit  
fi
    fun_start_vnts
	;;
vinfo)
        vnt_info
	http_response "$1"
    ;;
all)
        vnt_all
	http_response "$1"
    ;;
list)
        vnt_list
	http_response "$1"
    ;;
route)
       vnt_route
	http_response "$1"
    ;;
vnt_cli)
        vnt_cmds
	http_response "$1"
    ;;
vnts)
        vnts_cmds
	http_response "$1"
    ;;
clearvntlog)
        true >${vnt_log}
	http_response "$1"
    ;;
clearvntslog)
       true >${vnts_log}
	http_response "$1"
    ;;
updatevnt)
        fun_updatevnt
	http_response "$1"
    ;;
updatevnts)
        fun_updatevnts
	http_response "$1"
    ;;
restartvnt)
if [ "${vnt_enable}" != "1" ] ; then
   onkillvnt
   http_response "$1"
   exit 
fi

	fun_start_vnt
	http_response "$1"
    ;;
restartvnts)

if [ "${vnts_enable}" != "1" ] ; then
   onkillvnts  
   http_response "$1"
   exit   
fi
	fun_start_vnts
	http_response "$1"
    ;;
esac
# 界面提交的参数
case $2 in
1)
        logger "【软件中心】：启动 vnt..."
	fun_start_stop
	fun_nat_start
	fun_crontab
	http_response "$1"
	;;
start)
    if [ "${vnt_enable}" != "1" ] ; then
   onkillvnt

fi
if [ "${vnts_enable}" != "1" ] ; then
   onkillvnts
  
fi
    logger "【软件中心】：启动 vnt..."
	fun_start_stop
	fun_nat_start
	fun_crontab
	;;
stop)
	onstop
	;;
restart)
        onstop
        fun_start_stop
	fun_nat_start
	fun_crontab
	;;
vinfo)
        vnt_info
	http_response "$1"
    ;;
all)
        vnt_all 
	http_response "$1"
    ;;
list)
        vnt_list
	http_response "$1"
    ;;
route)
       vnt_route
	http_response "$1"
    ;;
vnt_cli)
        vnt_cmds
	http_response "$1"
    ;;
vnts)
        vnts_cmds
	http_response "$1"
    ;;
clearvntlog)
        true >${vnt_log}
	http_response "$1"
    ;;
clearvntslog)
       true >${vnts_log}
	http_response "$1"
    ;;
updatevnt)
	http_response "$1"
        fun_updatevnt
    ;;
updatevnts)
	http_response "$1"
        fun_updatevnts
    ;;
restartvnt)
       if [ "${vnt_enable}" != "1" ] ; then
   onkillvnt
   http_response "$1"
   exit 
fi
	http_response "$1"
	fun_start_vnt
    ;;
restartvnts)
	if [ "${vnts_enable}" != "1" ] ; then
   onkillvnts
   http_response "$1"
   exit 
fi
	http_response "$1"
	fun_start_vnts
    ;;
esac
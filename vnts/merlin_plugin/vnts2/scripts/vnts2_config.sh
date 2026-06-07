#!/bin/sh
source /koolshare/scripts/base.sh

# 获取前端传递的参数
vnts2_enable=$(dbus get vnts2_enable)
vnts2_token=$(dbus get vnts2_token)
vnts2_tcp_bind=$(dbus get vnts2_tcp_bind)
vnts2_quic_bind=$(dbus get vnts2_quic_bind)
vnts2_ws_bind=$(dbus get vnts2_ws_bind)
vnts2_network=$(dbus get vnts2_network)
vnts2_lease_duration=$(dbus get vnts2_lease_duration)
vnts2_web_bind=$(dbus get vnts2_web_bind)
vnts2_persistence=$(dbus get vnts2_persistence)
vnts2_username=$(dbus get vnts2_username)
vnts2_password=$(dbus get vnts2_password)
vnts2_cert=$(dbus get vnts2_cert)
vnts2_key=$(dbus get vnts2_key)
vnts2_whitelist=$(dbus get vnts2_whitelist)
vnts2_server_quic_bind=$(dbus get vnts2_server_quic_bind)
vnts2_peer_servers=$(dbus get vnts2_peer_servers)
vnts2_custom_nets=$(dbus get vnts2_custom_nets)

# 日志输出路径
LOG_FILE=/tmp/upload/vnts2_log.txt

# 辅助函数：将分隔字符串转换为 TOML 数组格式
format_toml_array() {
    local val="$1"
    if [ -z "$val" ]; then
        echo "[]"
        return
    fi
    # 将换行、竖线、逗号替换为空格，合并多余空格
    local normalized=$(echo "$val" | tr '\n' ' ' | tr '|' ' ' | tr ',' ' ' | tr -s ' ')
    # 去除首尾空格
    normalized=$(echo "$normalized" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    if [ -z "$normalized" ]; then
        echo "[]"
        return
    fi
    
    local result=""
    for item in $normalized; do
        if [ -z "$result" ]; then
            result="\"$item\""
        else
            result="$result, \"$item\""
        fi
    done
    echo "[$result]"
}

open_ports() {
    local tcp_port="${vnts2_tcp_bind##*:}"
    tcp_port="${tcp_port:-29872}"
    local quic_port="${vnts2_quic_bind##*:}"
    quic_port="${quic_port:-29872}"
    local ws_port="${vnts2_ws_bind##*:}"
    ws_port="${ws_port:-29872}"
    local web_port="${vnts2_web_bind##*:}"
    web_port="${web_port:-29871}"

    # 放行各端口的输入流量
    iptables -I INPUT -p tcp --dport $tcp_port -j ACCEPT 2>/dev/null
    ip6tables -I INPUT -p tcp --dport $tcp_port -j ACCEPT 2>/dev/null
    iptables -I INPUT -p udp --dport $quic_port -j ACCEPT 2>/dev/null
    ip6tables -I INPUT -p udp --dport $quic_port -j ACCEPT 2>/dev/null

    if [ "$ws_port" != "$tcp_port" ]; then
        iptables -I INPUT -p tcp --dport $ws_port -j ACCEPT 2>/dev/null
        ip6tables -I INPUT -p tcp --dport $ws_port -j ACCEPT 2>/dev/null
    fi

    iptables -I INPUT -p tcp --dport $web_port -j ACCEPT 2>/dev/null
    ip6tables -I INPUT -p tcp --dport $web_port -j ACCEPT 2>/dev/null
}

start_vnts() {
    echo_date "启动 vnts2 服务..." > $LOG_FILE
    open_ports
    
    # 确保专属数据目录存在并进入
    mkdir -p /koolshare/vnts2
    cd /koolshare/vnts2
    
    # 动态生成 config.toml，使用前端设置的值，空值则回退到合理默认值
    cat <<EOF > /koolshare/vnts2/config.toml
tcp_bind = "${vnts2_tcp_bind:-"0.0.0.0:29872"}"
quic_bind = "${vnts2_quic_bind:-"0.0.0.0:29872"}"
ws_bind = "${vnts2_ws_bind:-"0.0.0.0:29872"}"
network = "${vnts2_network:-"10.26.0.0/24"}"
lease_duration = ${vnts2_lease_duration:-86400}
web_bind = "${vnts2_web_bind:-"0.0.0.0:29871"}"
username = "${vnts2_username:-"admin"}"
password = "${vnts2_password:-"admin"}"
EOF

    # 数据持久化，0为false，其余为true
    if [ "$vnts2_persistence" = "0" ]; then
        echo "persistence = false" >> /koolshare/vnts2/config.toml
    else
        echo "persistence = true" >> /koolshare/vnts2/config.toml
    fi

    # 验证密码/Server Token设置
    if [ -n "$vnts2_token" ]; then
        echo "server_token = \"$vnts2_token\"" >> /koolshare/vnts2/config.toml
    fi

    # 自定义 TLS 证书与私钥路径
    if [ -n "$vnts2_cert" ]; then
        echo "cert = \"$vnts2_cert\"" >> /koolshare/vnts2/config.toml
    fi
    if [ -n "$vnts2_key" ]; then
        echo "key = \"$vnts2_key\"" >> /koolshare/vnts2/config.toml
    fi

    # 服务端互联监听端口
    if [ -n "$vnts2_server_quic_bind" ]; then
        echo "server_quic_bind = \"$vnts2_server_quic_bind\"" >> /koolshare/vnts2/config.toml
    fi

    # 白名单
    local whitelist_arr=$(format_toml_array "$vnts2_whitelist")
    echo "white_list = $whitelist_arr" >> /koolshare/vnts2/config.toml

    # 互联服务端地址列表
    local peers_arr=$(format_toml_array "$vnts2_peer_servers")
    echo "peer_servers = $peers_arr" >> /koolshare/vnts2/config.toml

    # 自定义虚拟网段
    echo "" >> /koolshare/vnts2/config.toml
    echo "[custom_nets]" >> /koolshare/vnts2/config.toml
    if [ -n "$vnts2_custom_nets" ]; then
        local nets_normalized=$(echo "$vnts2_custom_nets" | tr '\n' ' ' | tr '|' ' ' | tr ',' ' ' | tr -s ' ')
        for item in $nets_normalized; do
            local key=$(echo "$item" | cut -d'=' -f1)
            local value=$(echo "$item" | cut -d'=' -f2)
            if [ -n "$key" ] && [ -n "$value" ]; then
                key=$(echo "$key" | tr -d ' ')
                value=$(echo "$value" | tr -d ' ')
                echo "$key = \"$value\"" >> /koolshare/vnts2/config.toml
            fi
        done
    fi

    # 进入工作目录，后台启动进程，直接使用 & 运行，避免 start-stop-daemon 缺少 -d 参数导致失败
    cd /koolshare/vnts2
    /koolshare/bin/vnts2 -c /koolshare/vnts2/config.toml >> $LOG_FILE 2>&1 &
    
    # 检测是否启动成功
    sleep 2
    if [ -n "$(pidof vnts2)" ]; then
        echo_date "vnts2 服务启动成功！" >> $LOG_FILE
    else
        echo_date "vnts2 服务启动失败，请检查参数或查看日志。" >> $LOG_FILE
        dbus set vnts2_enable=0
    fi
}

close_ports() {
    local tcp_port="${vnts2_tcp_bind##*:}"
    tcp_port="${tcp_port:-29872}"
    local quic_port="${vnts2_quic_bind##*:}"
    quic_port="${quic_port:-29872}"
    local ws_port="${vnts2_ws_bind##*:}"
    ws_port="${ws_port:-29872}"
    local web_port="${vnts2_web_bind##*:}"
    web_port="${web_port:-29871}"

    # 清理防火墙规则
    iptables -D INPUT -p tcp --dport $tcp_port -j ACCEPT 2>/dev/null
    ip6tables -D INPUT -p tcp --dport $tcp_port -j ACCEPT 2>/dev/null
    iptables -D INPUT -p udp --dport $quic_port -j ACCEPT 2>/dev/null
    ip6tables -D INPUT -p udp --dport $quic_port -j ACCEPT 2>/dev/null

    if [ "$ws_port" != "$tcp_port" ]; then
        iptables -D INPUT -p tcp --dport $ws_port -j ACCEPT 2>/dev/null
        ip6tables -D INPUT -p tcp --dport $ws_port -j ACCEPT 2>/dev/null
    fi

    iptables -D INPUT -p tcp --dport $web_port -j ACCEPT 2>/dev/null
    ip6tables -D INPUT -p tcp --dport $web_port -j ACCEPT 2>/dev/null
}

stop_vnts() {
    echo_date "停止 vnts2 服务..." >> $LOG_FILE
    killall vnts2 >/dev/null 2>&1
    close_ports
}

# 检测第一个参数是否为数字（如果是，说明是 web/api 调用，第一个参数为请求ID，第二个参数为实际动作）
if [ -n "$1" ] && [ "$1" -eq "$1" ] 2>/dev/null; then
    AJAX_ID="$1"
    ACTION="$2"
else
    AJAX_ID=""
    ACTION="$1"
fi

case $ACTION in
start)
    if [ "$vnts2_enable" == "1" ]; then
        start_vnts
    fi
    ;;
stop)
    stop_vnts
    ;;
restart)
    stop_vnts
    sleep 1
    if [ "$vnts2_enable" == "1" ]; then
        start_vnts
    fi
    ;;
*)
    # Web 界面点击“提交”时，以 "submit" 或无动作参数的方式调用脚本
    if [ "$vnts2_enable" == "1" ]; then
        stop_vnts
        sleep 1
        start_vnts
    else
        stop_vnts
    fi
    ;;
esac

# 如果是 AJAX 调用，必须返回对应的 AJAX_ID 作为 response 结果以结束前端等待
if [ -n "$AJAX_ID" ]; then
    http_response "$AJAX_ID"
fi

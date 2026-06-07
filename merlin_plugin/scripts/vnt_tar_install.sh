#!/bin/sh

source /koolshare/scripts/base.sh
eval `dbus export vnt_`
alias echo_date='echo [$(TZ=UTC-8 date -R +%Y%m%d\ %X)]:'

vnt_name=$vnt_name
vnt_DIR=/tmp/upload

clean(){
    local RET=$1
    [ -n "$vnt_name" ] && rm -f ${vnt_DIR}/${vnt_name} >/dev/null 2>&1
    dbus remove vnt_name
    echo_date "======================== end ============================"
    exit ${RET}
}

install_tar(){
    echo_date "====================== step 1 ==========================="

    if [ -z "${vnt_name}" ]; then
        echo_date "No upload file found. Please upload via Web or SSH first."
        clean 1
    fi

    if [ ! -f "${vnt_DIR}/${vnt_name}" ]; then
        echo_date "File ${vnt_name} not found in ${vnt_DIR}"
        clean 1
    fi

    local _SIZE=$(ls -lh ${vnt_DIR}/${vnt_name} | awk '{print $5}')
    echo_date "Detected upload: ${vnt_name}, size: ${_SIZE}"
    echo_date "Note: client binary = vnt2_cli, server binary = vnts2"

    local vnt_bin_name=""
    local vnt_dir=""
    local vntclidir="$(dbus get vnt_path)"
    local vntsdir="$(dbus get vnts_path)"
    [ -z "$vntclidir" ] && vntclidir=/koolshare/bin/vnt2_cli
    [ -z "$vntsdir" ] && vntsdir=/koolshare/bin/vnts2

    if echo "$vnt_name" | grep -E -q "vnts2|vnts"; then
        vnt_bin_name="vnts2"
        vnt_dir="$vntsdir"
    elif echo "$vnt_name" | grep -E -q "vnt2_cli|vnt-cli|vnt_cli"; then
        vnt_bin_name="vnt2_cli"
        vnt_dir="$vntclidir"
    else
        echo_date "Cannot identify file: ${vnt_name}"
        echo_date "Client filename must contain vnt2_cli, server filename must contain vnts2"
        clean 1
    fi

    local JFFS_AVAIL=$(df | grep -w "/jffs$" | awk '{print $4}')
    if [ -n "$JFFS_AVAIL" ] && [ "${JFFS_AVAIL}" -lt "5048" ]; then
        echo_date "JFFS free space ${JFFS_AVAIL}KB < 5MB, installing to RAM (will be lost on reboot)"
        if [ "$vnt_bin_name" = "vnt2_cli" ]; then
            vnt_dir="/tmp/var/vnt2_cli"
            dbus set vnt_path=/tmp/var/vnt2_cli
        else
            vnt_dir="/tmp/var/vnts2"
            dbus set vnts_path=/tmp/var/vnts2
        fi
    fi

    if echo "$vnt_name" | grep -q "\.tar\.gz$"; then
        echo_date "Extracting tar.gz..."
        rm -rf /tmp/vnt-cli /tmp/vnts /tmp/vnt2_cli /tmp/vnts2 >/dev/null 2>&1
        tar -xzvf ${vnt_DIR}/${vnt_name} -C /tmp >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo_date "Extract failed. Please check the tar.gz file."
            clean 1
        fi
        echo_date "${vnt_name} extracted successfully"
        [ -f "/tmp/vnts" ] && [ ! -f "/tmp/vnts2" ] && mv /tmp/vnts /tmp/vnts2
        [ -f "/tmp/vnt-cli" ] && [ ! -f "/tmp/vnt2_cli" ] && mv /tmp/vnt-cli /tmp/vnt2_cli
        if [ ! -f "/tmp/${vnt_bin_name}" ]; then
            echo_date "${vnt_bin_name} not found in archive"
            clean 1
        fi
        cp -f /tmp/${vnt_bin_name} $vnt_dir
    else
        cp -f ${vnt_DIR}/${vnt_name} $vnt_dir
    fi

    chmod +x $vnt_dir
    local ver=$($vnt_dir --version 2>/dev/null | head -n 1 | awk '{print $2}')
    [ -z "$ver" ] && ver=$($vnt_dir -V 2>/dev/null | head -n 1 | awk '{print $2}')

    if [ -z "$ver" ]; then
        echo_date "Cannot run ${vnt_bin_name} - wrong arch or corrupted file"
        rm -f $vnt_dir >/dev/null 2>&1
        clean 1
    fi

    echo_date "Install success!"
    echo_date "Path: $vnt_dir"
    echo_date "Version: $ver"
    clean 0
}

echo " " >/tmp/upload/installvnt_log.txt
http_response "$1"
install_tar >>/tmp/upload/installvnt_log.txt 2>&1
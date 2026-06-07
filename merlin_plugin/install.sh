#! /bin/sh

source /koolshare/scripts/base.sh
eval `dbus export vnt_`
eval `dbus export vnts_`
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'

DIR=$(cd $(dirname $0); pwd)

en=`dbus get vnt_enable`
en2=`dbus get vnts_enable`

if [ ! -d "/koolshare" ] ; then
  echo_date "你的固件不是koolshare梅林，无法安装此插件包，请正确选择插件包！"
  rm -rf /tmp/vnt* >/dev/null 2>&1
  exit 1
fi
if [ "${en}"x = "1"x ] || [ "${en2}"x = "1"x ] ; then
    sh /koolshare/scripts/vnt_config.sh stop
fi
find /koolshare/init.d/ -name "*vnt.sh*"|xargs rm -rf
cd /tmp

# 判断及安装核心程序二进制
ARCH=$(uname -m)
IS_64BIT=0
if [ "$ARCH" == "aarch64" ]; then
    chmod +x /tmp/vnt/bin/vnts2_aarch64 >/dev/null 2>&1
    /tmp/vnt/bin/vnts2_aarch64 --version >/dev/null 2>&1
    if [ "$?" == "0" ]; then
        IS_64BIT=1
    fi
fi

if [ "$IS_64BIT" == "1" ]; then
    echo_date "检测到真 64 位用户态架构 (aarch64)，正在安装 64 位核心程序..."
    cp -rf /tmp/vnt/bin/vnt2_cli_aarch64 /koolshare/bin/vnt2_cli
    cp -rf /tmp/vnt/bin/vnt2_ctrl_aarch64 /koolshare/bin/vnt2_ctrl
    cp -rf /tmp/vnt/bin/vnts2_aarch64 /koolshare/bin/vnts2
    dbus set vnt_arch="aarch64 (64位)"
else
    echo_date "检测到 32 位用户态架构 (armv7)，正在安装 32 位核心程序..."
    cp -rf /tmp/vnt/bin/vnt2_cli_arm /koolshare/bin/vnt2_cli
    cp -rf /tmp/vnt/bin/vnt2_ctrl_arm /koolshare/bin/vnt2_ctrl
    cp -rf /tmp/vnt/bin/vnts2_arm /koolshare/bin/vnts2
    dbus set vnt_arch="armv7 (32位)"
fi

chmod +x /koolshare/bin/vnt2_cli
chmod +x /koolshare/bin/vnt2_ctrl
chmod +x /koolshare/bin/vnts2

cp -rf /tmp/vnt/scripts/* /koolshare/scripts/
cp -rf /tmp/vnt/webs/* /koolshare/webs/
cp -rf /tmp/vnt/res/* /koolshare/res/
cp /tmp/vnt/uninstall.sh /koolshare/scripts/uninstall_vnt.sh
ln -sf /koolshare/scripts/vnt_config.sh /koolshare/init.d/S49vnt.sh


chmod +x /koolshare/scripts/vnt_*
chmod +x /koolshare/scripts/uninstall_vnt.sh
chmod +x /koolshare/init.d/S49vnt.sh
dbus set softcenter_module_vnt_description=简便高效的异地组网、内网穿透工具
dbus set softcenter_module_vnt_install=1
dbus set softcenter_module_vnt_name=vnt
dbus set softcenter_module_vnt_title="vnt v2.0"
dbus set softcenter_module_vnt_version="$(cat $DIR/version)"

sleep 1
echo_date "vnt 插件安装完毕！"
rm -rf /tmp/vnt* >/dev/null 2>&1
en=`dbus get vnt_enable`
en2=`dbus get vnts_enable`
if [ "${en}"x = "1"x ] || [ "${en2}"x = "1"x ] ; then
    sh /koolshare/scripts/vnt_config.sh restart
fi
exit 0

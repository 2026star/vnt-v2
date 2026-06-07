#!/bin/sh
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh

echo_date "开始卸载 vnts2 插件..."

# 1. 停止服务
sh $KSROOT/scripts/vnts2_config.sh stop

# 2. 删除文件和目录
rm -rf $KSROOT/bin/vnts2
rm -rf $KSROOT/scripts/vnts2_*.sh
rm -rf $KSROOT/webs/Module_vnts2.asp
rm -rf $KSROOT/res/icon-vnts2.png
rm -rf $KSROOT/init.d/S99vnts2.sh
rm -rf $KSROOT/vnts2
rm -rf /tmp/upload/vnts2_log.txt

# 3. 清理数据库中的配置
for key in $(dbus list vnts2 | cut -d "=" -f 1)
do
    dbus remove $key
done
dbus remove softcenter_module_vnts2_install
dbus remove softcenter_module_vnts2_version
dbus remove softcenter_module_vnts2_name
dbus remove softcenter_module_vnts2_title
dbus remove softcenter_module_vnts2_description

# 4. 删除自己
rm -rf $KSROOT/scripts/uninstall_vnts2.sh

echo_date "vnts2 插件卸载完成！"
exit 0

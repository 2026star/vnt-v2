#!/bin/sh
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh

# 判断路由架构和环境... 略过复杂检测，这里是基础模板
echo_date "开始安装 vnts2 插件..."

# 判断路由架构 (通过试运行检测是否是真 64 位用户态环境)
ARCH=$(uname -m)
IS_64BIT=0
if [ "$ARCH" == "aarch64" ]; then
    # 试运行 64 位二进制文件，若能正常运行则确认为真 64 位用户态
    chmod +x /tmp/vnts2/bin/vnts_aarch64 >/dev/null 2>&1
    /tmp/vnts2/bin/vnts_aarch64 --conf_example >/dev/null 2>&1
    if [ "$?" == "0" ]; then
        IS_64BIT=1
    fi
fi

if [ "$IS_64BIT" == "1" ]; then
    echo_date "检测到真 64 位用户态架构 (aarch64)，正在安装 64 位版本..."
    cp -rf /tmp/vnts2/bin/vnts_aarch64 $KSROOT/bin/vnts2
    dbus set vnts2_arch="aarch64 (64位)"
else
    echo_date "检测到 32 位用户态架构 (armv7) 运行环境 (如 AC86U / AX86U)..."
    cp -rf /tmp/vnts2/bin/vnts_arm $KSROOT/bin/vnts2
    dbus set vnts2_arch="armv7 (32位)"
fi

# 创建专属配置及运行数据目录
mkdir -p $KSROOT/vnts2

# 1. 复制其他文件到对应目录
cp -rf /tmp/vnts2/scripts/* $KSROOT/scripts/
cp -rf /tmp/vnts2/webs/* $KSROOT/webs/
cp -rf /tmp/vnts2/res/* $KSROOT/res/ 2>/dev/null || true
cp -rf /tmp/vnts2/uninstall.sh $KSROOT/scripts/uninstall_vnts2.sh

# 2. 赋予执行权限
chmod +x $KSROOT/bin/vnts2
chmod +x $KSROOT/scripts/vnts2_*.sh
chmod +x $KSROOT/scripts/uninstall_vnts2.sh

# 3. 创建开机自启软链接
ln -sf $KSROOT/scripts/vnts2_config.sh $KSROOT/init.d/S99vnts2.sh

# 3. 初始化默认配置（如果有必要）
dbus set vnts2_version="1.1"

# 4. 设置离线安装包的显示名和描述等信息
dbus set softcenter_module_vnts2_install="1"
dbus set softcenter_module_vnts2_version="1.1"
dbus set softcenter_module_vnts2_name="vnts2"
dbus set softcenter_module_vnts2_title="VNTS2"
dbus set softcenter_module_vnts2_description="VNT2 组网服务端"

# 清理临时安装包目录
rm -rf /tmp/vnts2*

echo_date "vnts2 插件安装完成！"
exit 0

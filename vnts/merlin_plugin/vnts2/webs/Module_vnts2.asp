<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<meta HTTP-EQUIV="Expires" CONTENT="-1"/>
<link rel="shortcut icon" href="images/favicon.png"/>
<link rel="icon" href="images/favicon.png"/>
<title>软件中心 - VNTS2</title>
<link rel="stylesheet" type="text/css" href="index_style.css"/>
<link rel="stylesheet" type="text/css" href="form_style.css"/>
<link rel="stylesheet" type="text/css" href="usp_style.css"/>
<link rel="stylesheet" type="text/css" href="css/element.css">
<link rel="stylesheet" type="text/css" href="/res/softcenter.css">
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script type="text/javascript" src="/validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/res/softcenter.js"></script>
<script>
var dbus = {};

function menu_hook(title, tab) {
    tabtitle[tabtitle.length - 1] = new Array("", "VNTS2");
    tablink[tablink.length - 1] = new Array("", "Module_vnts2.asp");
}

function get_previous() {
    location.href = "Module_Softcenter.asp";
}

function init() {
    try {
        show_menu(menu_hook);
    } catch (e) {
        console.log("Failed to show menu, maybe in AP/Repeater mode:", e);
    }
    get_dbus_data();
    get_status();
}

function get_dbus_data() {
    try {
        $.ajax({
            type: "GET",
            url: "/_api/vnts2",
            dataType: "json",
            async: false,
            success: function(data) {
                if (data && data.result && data.result[0]) {
                    dbus = data.result[0];
                } else {
                    dbus = {};
                }
                
                // 开关设置
                if (E("vnts2_enable")) E("vnts2_enable").checked = dbus["vnts2_enable"] == "1";
                
                // 各输入框绑定
                if (E("vnts2_token")) E("vnts2_token").value = dbus["vnts2_token"] || "";
                if (E("vnts2_tcp_bind")) E("vnts2_tcp_bind").value = dbus["vnts2_tcp_bind"] || "0.0.0.0:29872";
                if (E("vnts2_quic_bind")) E("vnts2_quic_bind").value = dbus["vnts2_quic_bind"] || "0.0.0.0:29872";
                if (E("vnts2_ws_bind")) E("vnts2_ws_bind").value = dbus["vnts2_ws_bind"] || "0.0.0.0:29872";
                if (E("vnts2_network")) E("vnts2_network").value = dbus["vnts2_network"] || "10.26.0.0/24";
                if (E("vnts2_lease_duration")) E("vnts2_lease_duration").value = dbus["vnts2_lease_duration"] || "86400";
                if (E("vnts2_web_bind")) E("vnts2_web_bind").value = dbus["vnts2_web_bind"] || "0.0.0.0:29871";
                if (E("vnts2_username")) E("vnts2_username").value = dbus["vnts2_username"] || "admin";
                if (E("vnts2_password")) E("vnts2_password").value = dbus["vnts2_password"] || "admin";
                if (E("vnts2_cert")) E("vnts2_cert").value = dbus["vnts2_cert"] || "";
                if (E("vnts2_key")) E("vnts2_key").value = dbus["vnts2_key"] || "";
                if (E("vnts2_whitelist")) E("vnts2_whitelist").value = dbus["vnts2_whitelist"] || "";
                if (E("vnts2_server_quic_bind")) E("vnts2_server_quic_bind").value = dbus["vnts2_server_quic_bind"] || "";
                if (E("vnts2_peer_servers")) E("vnts2_peer_servers").value = dbus["vnts2_peer_servers"] || "";
                if (E("vnts2_custom_nets")) E("vnts2_custom_nets").value = dbus["vnts2_custom_nets"] || "";
                
                // 数据持久化（默认开启）
                if (E("vnts2_persistence")) E("vnts2_persistence").checked = dbus["vnts2_persistence"] !== "0";
                
                // 显示架构信息
                if (E("vnts2_arch")) {
                    if (dbus["vnts2_arch"]) {
                        E("vnts2_arch").innerHTML = dbus["vnts2_arch"];
                    } else {
                        E("vnts2_arch").innerHTML = "尚未安装/未知";
                    }
                }
            }
        });
    } catch (e) {
        console.log("Failed to get dbus data:", e);
    }
}

function get_status() {
    var id = parseInt(Math.random() * 100000000);
    var postData = {"id": id, "method": "vnts2_status.sh", "params": [], "fields": ""};
    $.ajax({
        type: "POST",
        url: "/_api/",
        data: JSON.stringify(postData),
        dataType: "json",
        success: function(response) {
            if (response && response.result) {
                E("vnts2_status").innerHTML = response.result;
            } else {
                E("vnts2_status").innerHTML = "获取状态失败";
            }
        },
        error: function() {
            E("vnts2_status").innerHTML = "获取状态失败";
        }
    });
    setTimeout("get_status()", 5000);
}

function save() {
    var id = parseInt(Math.random() * 100000000);
    var postData = {"id": id, "method": "vnts2_config.sh", "params": ["submit"], "fields": {}};
    
    if (E("vnts2_enable")) postData.fields.vnts2_enable = E("vnts2_enable").checked ? "1" : "0";
    if (E("vnts2_token")) postData.fields.vnts2_token = E("vnts2_token").value;
    if (E("vnts2_tcp_bind")) postData.fields.vnts2_tcp_bind = E("vnts2_tcp_bind").value;
    if (E("vnts2_quic_bind")) postData.fields.vnts2_quic_bind = E("vnts2_quic_bind").value;
    if (E("vnts2_ws_bind")) postData.fields.vnts2_ws_bind = E("vnts2_ws_bind").value;
    if (E("vnts2_network")) postData.fields.vnts2_network = E("vnts2_network").value;
    if (E("vnts2_lease_duration")) postData.fields.vnts2_lease_duration = E("vnts2_lease_duration").value;
    if (E("vnts2_web_bind")) postData.fields.vnts2_web_bind = E("vnts2_web_bind").value;
    if (E("vnts2_persistence")) postData.fields.vnts2_persistence = E("vnts2_persistence").checked ? "1" : "0";
    if (E("vnts2_username")) postData.fields.vnts2_username = E("vnts2_username").value;
    if (E("vnts2_password")) postData.fields.vnts2_password = E("vnts2_password").value;
    if (E("vnts2_cert")) postData.fields.vnts2_cert = E("vnts2_cert").value;
    if (E("vnts2_key")) postData.fields.vnts2_key = E("vnts2_key").value;
    if (E("vnts2_whitelist")) postData.fields.vnts2_whitelist = E("vnts2_whitelist").value;
    if (E("vnts2_server_quic_bind")) postData.fields.vnts2_server_quic_bind = E("vnts2_server_quic_bind").value;
    if (E("vnts2_peer_servers")) postData.fields.vnts2_peer_servers = E("vnts2_peer_servers").value;
    if (E("vnts2_custom_nets")) postData.fields.vnts2_custom_nets = E("vnts2_custom_nets").value;

    $.ajax({
        type: "POST",
        url: "/_api/",
        data: JSON.stringify(postData),
        dataType: "json",
        success: function(response) {
            alert("配置已保存，正在重启服务！");
            setTimeout("get_status()", 3000);
        }
    });
}
</script>
</head>
<body onload="init();">
<div id="TopBanner"></div>
<div id="Loading" class="popup_bg"></div>
<table class="content" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td width="17">&nbsp;</td>
        <td valign="top" width="202">
            <div id="mainMenu"></div>
            <div id="subMenu"></div>
        </td>
        <td valign="top">
            <div id="tabMenu" class="submenuBlock"></div>
            <table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="left" valign="top">
                        <table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3" class="FormTitle" id="FormTitle">
                            <tr>
                                <td bgcolor="#4D595D" colspan="3" valign="top">
                                    <div>&nbsp;</div>
                                    <div class="formfonttitle">软件中心 - VNTS2</div>
                                    <div style="float:right; width:15px; height:25px;margin-top:-20px">
                                        <img id="return_btn" onclick="get_previous();" align="right" style="cursor:pointer;position:absolute;margin-left:-30px;margin-top:-25px;" title="返回软件中心" src="/images/backprev.png" onMouseOver="this.src='/images/backprevclick.png'" onMouseOut="this.src='/images/backprev.png'"></img>
                                    </div>
                                    <div style="margin:10px 0 10px 5px;" class="splitLine"></div>
                                    <div class="SimpleNote">
                                        <li>vnts2 是一款虚拟局域网工具服务端。</li>
                                    </div>
                                    
                                    <table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable">
                                        <tr>
                                            <th>开关设置</th>
                                            <td colspan="2">
                                                <div class="switch_field" style="display:table-cell;float:left;margin-top:0px;">
                                                    <label for="vnts2_enable">
                                                        <input id="vnts2_enable" class="switch" type="checkbox" style="display: none;">
                                                        <div class="switch_container" >
                                                            <div class="switch_bar"></div>
                                                            <div class="switch_circle transition_style">
                                                                <div></div>
                                                            </div>
                                                        </div>
                                                    </label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>运行状态</th>
                                            <td colspan="2"><span id="vnts2_status">正在获取...</span></td>
                                        </tr>
                                        <tr>
                                            <th>当前运行架构</th>
                                            <td colspan="2">
                                                <span id="vnts2_arch" style="color: #4cae4c; font-weight: bold;">正在获取...</span>
                                                <span style="color: #999; font-size: 12px; margin-left: 10px;">(系统安装时自动识别)</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Server Token</th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_token" value="" placeholder="选填，设置服务端验证密码" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>虚拟局域网网段</th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_network" value="10.26.0.0/24" placeholder="默认: 10.26.0.0/24" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>IP 租约时长(秒)</th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_lease_duration" value="86400" placeholder="默认: 86400 (24小时)" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>数据持久化</th>
                                            <td colspan="2">
                                                <div class="switch_field" style="display:table-cell;float:left;margin-top:0px;">
                                                    <label for="vnts2_persistence">
                                                        <input id="vnts2_persistence" class="switch" type="checkbox" style="display: none;">
                                                        <div class="switch_container" >
                                                            <div class="switch_bar"></div>
                                                            <div class="switch_circle transition_style">
                                                                <div></div>
                                                            </div>
                                                        </div>
                                                    </label>
                                                </div>
                                            </td>
                                        </tr>

                                        <!-- 网口绑定设置 -->
                                        <tr style="background-color: #576d73; color: #fff;">
                                            <td colspan="3" style="font-weight: bold; padding: 6px 10px;">网口绑定设置</td>
                                        </tr>
                                        <tr>
                                            <th>TCP 绑定端口</th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_tcp_bind" value="0.0.0.0:29872" placeholder="默认: 0.0.0.0:29872" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>QUIC 绑定端口</th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_quic_bind" value="0.0.0.0:29872" placeholder="默认: 0.0.0.0:29872" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>WS/WSS 绑定端口</th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_ws_bind" value="0.0.0.0:29872" placeholder="默认: 0.0.0.0:29872" />
                                            </td>
                                        </tr>

                                        <!-- Web 管理端设置 -->
                                        <tr style="background-color: #576d73; color: #fff;">
                                            <td colspan="3" style="font-weight: bold; padding: 6px 10px;">Web 管理端设置</td>
                                        </tr>
                                        <tr>
                                            <th>Web 管理端绑定端口</th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_web_bind" value="0.0.0.0:29871" placeholder="默认: 0.0.0.0:29871" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Web 登录用户名</th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_username" value="admin" placeholder="默认: admin" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Web 登录密码</th>
                                            <td colspan="2">
                                                <input type="password" class="input_ss_table" id="vnts2_password" value="admin" placeholder="默认: admin" onBlur="switchType(this, false);" onFocus="switchType(this, true);" autocomplete="new-password" />
                                            </td>
                                        </tr>

                                        <!-- 安全与证书设置 -->
                                        <tr style="background-color: #576d73; color: #fff;">
                                            <td colspan="3" style="font-weight: bold; padding: 6px 10px;">安全与证书设置 (选填)</td>
                                        </tr>
                                        <tr>
                                            <th>TLS 证书路径 (cert)</th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_cert" value="" placeholder="选填，例如: /koolshare/vnts2/cert.pem" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>TLS 私钥路径 (key)</th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_key" value="" placeholder="选填，例如: /koolshare/vnts2/key.pem" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>网络编号白名单</th>
                                            <td colspan="2">
                                                <textarea type="text" class="input_ss_table" id="vnts2_whitelist" placeholder="选填，允许连接的网络编号。多个网络编号以英文逗号 ','、'|' 或换行分隔" style="height: 60px; font-family:'Courier New', Courier, mono; font-size: 11px;"></textarea>
                                            </td>
                                        </tr>

                                        <!-- 服务端互联设置 -->
                                        <tr style="background-color: #576d73; color: #fff;">
                                            <td colspan="3" style="font-weight: bold; padding: 6px 10px;">服务端互联设置 (选填)</td>
                                        </tr>
                                        <tr>
                                            <th>互联监听地址 (quic_bind)</th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_server_quic_bind" value="" placeholder="例如: 0.0.0.0:29873" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>其他互联服务器地址</th>
                                            <td colspan="2">
                                                <textarea type="text" class="input_ss_table" id="vnts2_peer_servers" placeholder="选填，其他服务器的互联地址（IP:Port）。多个地址以英文逗号 ','、'|' 或换行分隔" style="height: 60px; font-family:'Courier New', Courier, mono; font-size: 11px;"></textarea>
                                            </td>
                                        </tr>

                                        <!-- 自定义网段映射 -->
                                        <tr style="background-color: #576d73; color: #fff;">
                                            <td colspan="3" style="font-weight: bold; padding: 6px 10px;">自定义网段映射 (选填)</td>
                                        </tr>
                                        <tr>
                                            <th>自定义虚拟网段</th>
                                            <td colspan="2">
                                                <textarea type="text" class="input_ss_table" id="vnts2_custom_nets" placeholder="选填，格式为: 网络编号 = 网段 (例如 net1=10.25.0.0/24)。一行输入一条，以换行或逗号分隔" style="height: 60px; font-family:'Courier New', Courier, mono; font-size: 11px;"></textarea>
                                            </td>
                                        </tr>
                                    </table>
                                    
                                    <div class="apply_gen">
                                        <input class="button_gen" id="cmdBtn" onClick="save()" type="button" value="提交" />
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td width="10" align="center" valign="top"></td>
    </tr>
</table>
</body>
</html>

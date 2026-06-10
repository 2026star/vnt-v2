<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<meta HTTP-EQUIV="Expires" CONTENT="-1"/>
<link rel="shortcut icon" href="images/favicon.png"/>
<link rel="icon" href="images/favicon.png"/>
<title>软件中心 - VNT 异地组网、内网穿透工具</title>
<link rel="stylesheet" type="text/css" href="index_style.css" />
<link rel="stylesheet" type="text/css" href="form_style.css" />
<link rel="stylesheet" type="text/css" href="usp_style.css" />
<link rel="stylesheet" type="text/css" href="ParentalControl.css">
<link rel="stylesheet" type="text/css" href="css/icon.css">
<link rel="stylesheet" type="text/css" href="css/element.css">
<link rel="stylesheet" type="text/css" href="/res/layer/theme/default/layer.css">
<link rel="stylesheet" type="text/css" href="res/softcenter.css">
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script type="text/javascript" src="/validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/switcherplugin/jquery.iphone-switch.js"></script>
<script type="text/javascript" src="/res/softcenter.js"></script>
<style type="text/css">
.show-btn1, .show-btn2, .show-btn3 {
    border: 1px solid #222;
    background: #576d73;
    font-size:10pt;
    color: #fff;
    padding: 10px 3.75px;
    border-radius: 5px 5px 0px 0px;
    width:15%;
    }
.active {
    background: #807e79;
}
.close {
    background: red;
    color: black;
    border-radius: 12px;
    line-height: 18px;
    text-align: center;
    height: 18px;
    width: 18px;
    font-size: 16px;
    padding: 1px;
    top: -10px;
    right: -10px;
    position: absolute;
}
/* use cross as close button */
.close::before {
    content: "\2716";
}
.contentM_qis {
    position: fixed;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius:10px;
    z-index: 10;
    background-color:#2B373B;
    /*margin-left: -100px;*/
    top: 100px;
    width:755px;
    return height:auto;
    box-shadow: 3px 3px 10px #000;
    background: rgba(0,0,0,0.85);
    display:none;
}
.user_title{
    text-align:center;
    font-size:18px;
    color:#99FF00;
    padding:10px;
    font-weight:bold;
}
.info_btn {
    border: 1px solid #222;
    background: linear-gradient(to bottom, #003333  0%, #000000 100%); /* W3C */
    font-size:10pt;
    color: #fff;
    padding: 5px 5px;
    border-radius: 5px 5px 5px 5px;
    width:16%;
}
.info_btn:hover {
    border: 1px solid #222;
    background: linear-gradient(to bottom, #27c9c9  0%, #279fd9 100%); /* W3C */
    font-size:10pt;
    color: #fff;
    padding: 5px 5px;
    border-radius: 5px 5px 5px 5px;
    width:16%;
}

.formbottomdesc {
    margin-top:10px;
    margin-left:10px;
}
input[type=button]:focus {
    outline: none;
}
.vnt_custom_btn {
    border: 1px solid #222;
    background: linear-gradient(to bottom, #003333 0%, #000000 100%);
    font-size: 10pt;
    color: #fff;
    padding: 5px 5px;
    border-radius: 5px;
    width: auto;
}

.vnt_custom_btn:hover {
    background: linear-gradient(to bottom, #27c9c9 0%, #279fd9 100%);
}
.web_btn {
    border: 1px solid #222;
    background: linear-gradient(to bottom, #003333  0%, #000000 100%); /* W3C */
    font-size:10pt;
    color: #fff;
    padding: 5px 5px;
    border-radius: 5px 5px 5px 5px;
    width:auto;
}
.web_btn:hover {
    border: 1px solid #222;
    background: linear-gradient(to bottom, #27c9c9  0%, #279fd9 100%); /* W3C */
    font-size:10pt;
    color: #fff;
    padding: 5px 5px;
    border-radius: 5px 5px 5px 5px;
    width:auto;
}
</style>
<script>
var db_vnt = {};
var params_input = [
    "vnt_cron_time", "vnt_cron_hour_min", "vnt_cron_type",
    "vnts_cron_time", "vnts_cron_hour_min", "vnts_cron_type",
    "vnt_token", "vnt_ipmode", "vnt_static_ip", "vnt_desvice_id", "vnt_desvice_name",
    "vnt_localadd", "vnt_peeradd", "vnt_serveraddr", "vnt_stunaddr", "vnt_tun_name",
    "vnt_relay_enable", "vnt_mtu", "vnt_key",
    "vnt_path", "vnt_mapping", "vnt_cert_mode", "vnt_tunnel_port",
    "vnts_path",
    "vnts2_token", "vnts2_tcp_bind", "vnts2_quic_bind", "vnts2_ws_bind",
    "vnts2_network", "vnts2_lease_duration", "vnts2_web_bind",
    "vnts2_username", "vnts2_password", "vnts2_cert", "vnts2_key",
    "vnts2_whitelist", "vnts2_server_quic_bind", "vnts2_peer_servers", "vnts2_custom_nets", "vnts2_default_secret", "vnts2_network_secrets"
];
var params_check = [
    "vnt_enable", "vnts_enable", "vnt_proxy_enable", "vnt_compressor",
    "vnt_first_latency_enable", "vnt_fec", "vnt_allow_mapping", "vnt_no_tun",
    "vnts2_persistence"
];
function initial() {
	show_menu(menu_hook);
	get_dbus_data();
	get_vnt_status();
	toggle_func();
	conf2obj();
	buildswitch();
	get_installog();
}
function get_dbus_data() {
	$.ajax({
		type: "GET",
		url: "/_api/vnt",
		dataType: "json",
		async: false,
		success: function(data) {
			if (data && data.result && data.result[0]) {
				db_vnt = data.result[0];
			} else {
				db_vnt = {};
			}
			conf2obj();
			update_visibility();
			toggle_func();
		}
	});
}

function conf2obj() {
	//input
	for (var i = 0; i < params_input.length; i++) {
		var el = E(params_input[i]);
		if (el) {
			var val = db_vnt[params_input[i]];
			if (val === undefined || val === null || val === "") {
				// Provide defaults for specific fields
				if (params_input[i] === "vnt_serveraddr") val = "tcp://127.0.0.1:29872";
				else if (params_input[i] === "vnt_tun_name") val = "vnt-tun";
				else if (params_input[i] === "vnt_relay_enable") val = "p2p";
				else if (params_input[i] === "vnt_ipmode") val = "dhcp";
				else if (params_input[i] === "vnt_cert_mode") val = "skip";
				else if (params_input[i] === "vnts2_tcp_bind") val = "0.0.0.0:29872";
				else if (params_input[i] === "vnts2_quic_bind") val = "0.0.0.0:29872";
				else if (params_input[i] === "vnts2_ws_bind") val = "0.0.0.0:29872";
				else if (params_input[i] === "vnts2_network") val = "10.26.0.0/24";
				else if (params_input[i] === "vnts2_lease_duration") val = "86400";
				else if (params_input[i] === "vnts2_web_bind") val = "0.0.0.0:29871";
				else if (params_input[i] === "vnts2_username") val = "admin";
				else if (params_input[i] === "vnts2_password") val = "admin";
				else val = "";
			}
			el.value = val;
		}
	}
	// checkbox
	for (var i = 0; i < params_check.length; i++) {
		var el = E(params_check[i]);
		if (el) {
			var val = db_vnt[params_check[i]];
			if (val === undefined || val === null || val === "") {
				if (params_check[i] === "vnts2_persistence") {
					el.checked = true;
				} else {
					el.checked = false;
				}
			} else {
				el.checked = val == "1";
			}
		}
	}
}


function get_vnt_status() {
		var postData = {
			"id": parseInt(Math.random() * 100000000),
			"method": "vnt_status.sh",
			"params": [],
			"fields": ""
		};
		$.ajax({
			type: "POST",
			cache: false,
			url: "/_api/",
			data: JSON.stringify(postData),
			dataType: "json",
			success: function(response) {
				if (typeof response.result === "string" && response.result) {
        var resultArray = response.result.split('|'); 
        if (resultArray.length >= 2) {
            E("status1").innerHTML = resultArray[0]; 
            E("status2").innerHTML = resultArray[1]; 
        }
    }
    setTimeout("get_vnt_status();", 10000);
},
			error: function() {
				setTimeout("get_vnt_status();", 5000);
			}
		});
	}


function buildswitch() {
	$("#vnt_enable").click(function() {
		document.form.vnt_enable.value = E('vnt_enable').checked ? 1 : 0;
	});
	$("#vnts_enable").click(function() {
		document.form.vnts_enable.value = E('vnts_enable').checked ? 1 : 0;
	});
	$("#vnt_proxy_enable").click(function() {
		document.form.vnt_proxy_enable.value = E('vnt_proxy_enable').checked ? 1 : 0;
	});
	$("#vnt_compressor").click(function() {
		document.form.vnt_compressor.value = E('vnt_compressor').checked ? 1 : 0;
	});
	$("#vnt_no_tun").click(function() {
		document.form.vnt_no_tun.value = E('vnt_no_tun').checked ? 1 : 0;
	});
	$("#vnt_first_latency_enable").click(function() {
		document.form.vnt_first_latency_enable.value = E('vnt_first_latency_enable').checked ? 1 : 0;
	});
	$("#vnt_fec").click(function() {
		document.form.vnt_fec.value = E('vnt_fec').checked ? 1 : 0;
	});
	$("#vnt_allow_mapping").click(function() {
		document.form.vnt_allow_mapping.value = E('vnt_allow_mapping').checked ? 1 : 0;
	});
	$("#vnts2_persistence").click(function() {
		document.form.vnts2_persistence.value = E('vnts2_persistence').checked ? 1 : 0;
	});
}
function openWebInterface() {
    var web_bind = document.getElementById('vnts2_web_bind').value || "0.0.0.0:29871";
    var web_port = web_bind.split(':')[1] || "29871";
    var webUiHref = "http://" + window.location.hostname + ":" + web_port;
    window.open(webUiHref, '_blank');
}
function save() {
	if (E("vnt_enable") && E("vnt_enable").checked) {
		if (trim(E("vnt_token").value) == "") {
			alert("客户端Token为必填项!");
			return false;
		}
	}
	if (E("vnt_cron_time") && trim(E("vnt_cron_time").value) == "") {
		alert("客户端定时功能不能为空! 不使用请填0");
		return false;
	}
	if (E("vnts_cron_time") && trim(E("vnts_cron_time").value) == "") {
		alert("服务端定时功能不能为空! 不使用请填0");
		return false;
	}
	if (E("vnt_enable") && E("vnt_enable").checked && E("vnt_ipmode") && E("vnt_ipmode").value == "static") {
		if (E("vnt_static_ip") && trim(E("vnt_static_ip").value) == "") {
			alert("选择静态指定IP，必须填写分配的虚拟IP地址！");
			return false;
		}
	}

	if (E("vnt_cron_time") && E("vnt_cron_time").value == "0") {
		if (E("vnt_cron_hour_min")) E("vnt_cron_hour_min").value = "";
		if (E("vnt_cron_type")) E("vnt_cron_type").value = "";
	}
	if (E("vnts_cron_time") && E("vnts_cron_time").value == "0") {
		if (E("vnts_cron_hour_min")) E("vnts_cron_hour_min").value = "";
		if (E("vnts_cron_type")) E("vnts_cron_type").value = "";
	}
	if (E("vnt_ipmode") && E("vnt_ipmode").value == "dhcp") {
		if (E("vnt_static_ip")) E("vnt_static_ip").value = "";
	}

	showLoading(3);

	//input
	for (var i = 0; i < params_input.length; i++) {
		var el = E(params_input[i]);
		if (el) {
			var val = trim(el.value);
			if (val && val != db_vnt[params_input[i]]) {
				db_vnt[params_input[i]] = val;
			} else if (!val && db_vnt[params_input[i]]) {
				db_vnt[params_input[i]] = "";
			}
		}
	}
	// checkbox
	for (var i = 0; i < params_check.length; i++) {
		var el = E(params_check[i]);
		if (el) {
			var val = el.checked ? '1' : '0';
			if (val != db_vnt[params_check[i]]) {
				db_vnt[params_check[i]] = val;
			}
		}
	}
	
	// post data
	var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": [1], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
				refreshpage();
			}
		}
	});
}
function clear_vntlog() {
	var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["clearvntlog"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
				E("vnt_logtxt").value = "日志文件为空或程序未启动";
			}
		}
	});
}
function clear_vntslog() {
	var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["clearvntslog"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
				E("vnts_logtxt").value = "日志文件为空或程序未启动";
			}
		}
	});
}
function menu_hook(title, tab) {
	tabtitle[tabtitle.length - 1] = new Array("", "VNT");
	tablink[tablink.length - 1] = new Array("", "Module_vnt.asp");
}

function get_vnt_log() {
	$.ajax({
		url: '/_temp/vnt-cli.log',
		type: 'GET',
		cache:false,
		dataType: 'text',
		success: function(res) {
            if (!res || res.length == 0){
            E("vnt_logtxt").value = "日志文件为空或程序未启动"; 
			}else{ $('#vnt_logtxt').val(res); 
                      var textarea = document.getElementById('vnt_logtxt');
                      textarea.scrollTop = textarea.scrollHeight;
                    }
		}
	});
}
function get_vnt_info() {
	var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["vinfo"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
			$.ajax({
		url: '/_temp/vnt_info.log',
		type: 'GET',
		cache:false,
		dataType: 'text',
		success: function(res) {
            if (res.length == 0){
            E("vnt_infotxt").value = "未获取到本机设备信息或程序未启动"; 
            get_vnt_info();
			}else{ $('#vnt_infotxt').val(res); }
		}
	});
			}
		}
	});
}
function get_vnt_all() {
	var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["all"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
				$.ajax({
		url: '/_temp/vnt_all.log',
		type: 'GET',
		cache:false,
		dataType: 'text',
		success: function(res) {
            if (res.length == 0){
            E("vnt_alltxt").value = "未获取到所有设备信息或程序未启动"; 
            get_vnt_all();
			}else{ $('#vnt_alltxt').val(res); }
		}
	});
			}
		}
	});
}
function get_vnt_list() {
	var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["list"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
				$.ajax({
		url: '/_temp/vnt_list.log',
		type: 'GET',
		cache:false,
		dataType: 'text',
		success: function(res) {
            if (res.length == 0){
            E("vnt_listtxt").value = "未获取到所有列表信息或程序未启动"; 
            get_vnt_list();
			}else{ $('#vnt_listtxt').val(res); }
		}
	});
			}
		}
	});
}
function get_vnt_route() {
	var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["route"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
				$.ajax({
		url: '/_temp/vnt_route.log',
		type: 'GET',
		cache:false,
		dataType: 'text',
		success: function(res) {
            if (res.length == 0){
            E("vnt_routetxt").value = "未获取到路由转发信息或程序未启动"; 
            get_vnt_route();
			}else{ $('#vnt_routetxt').val(res); }
		}
	});
			}
		}
	});
}
function get_vnt_cmd() {
	var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["vnt_cli"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
				$.ajax({
		url: '/_temp/vnt_cmd.log',
		type: 'GET',
		cache:false,
		dataType: 'text',
		success: function(res) {
            if (res.length == 0){
            E("vnt_cmdtxt").value = "未获取到程序启动参数或程序未启动"; 
            get_vnt_cmd();
			}else{ $('#vnt_cmdtxt').val(res); }
		}
	});
			}
		}
	});
}
function get_vnts_log() {
	$.ajax({
		url: '/_temp/vnts.log',
		type: 'GET',
		cache:false,
		dataType: 'text',
		success: function(res) {
            if (!res || res.length == 0){
            E("vnts_logtxt").value = "日志文件为空或程序未启动"; 
			}else{ $('#vnts_logtxt').val(res); 
                      var textarea = document.getElementById('vnts_logtxt');
                      textarea.scrollTop = textarea.scrollHeight;
                  }
		}
	});
}
function get_vnts_cmd() {
	var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["vnts"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
				$.ajax({
		url: '/_temp/vnts_cmd.log',
		type: 'GET',
		cache:false,
		dataType: 'text',
		success: function(res) {
            if (res.length == 0){
            E("vnts_cmdtxt").value = "未获取到程序启动参数或程序未启动"; 
            get_vnts_cmd();
			}else{ $('#vnts_cmdtxt').val(res); }
		}
	});
			}
		}
	});
}
function get_vnts_fingerprint() {
	var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["vnts_fingerprint"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
				$.ajax({
					url: '/_temp/vnts_fingerprint.log',
					type: 'GET',
					cache:false,
					dataType: 'text',
					success: function(res) {
						if (!res || res.length == 0 || res.trim() == "未找到Fingerprint" || res.trim() == "未在日志中找到 Fingerprint" || res.trim() == ""){
							E("vnts_fingerprinttxt").value = "未在日志中找到 Fingerprint，服务端可能未启动或日志已滚动。"; 
							get_vnts_fingerprint();
						}else{ 
							$('#vnts_fingerprinttxt').val(res); 
						}
					}
				});
			}
		}
	});
}
function open_conf(open_conf) {
	if (open_conf == "vnt_info") {
		get_vnt_info();
		console.log("vnt_info")
	}
	if (open_conf == "vnt_all") {
		get_vnt_all();
		console.log("vnt_all")
	}
	if (open_conf == "vnt_list") {
		get_vnt_list();
		console.log("vnt_list")
	}
	if (open_conf == "vnt_route") {
		get_vnt_route();
		console.log("vnt_route")
	}
	if (open_conf == "vnt_cmd") {
		get_vnt_cmd();
		console.log("vnt_cmd")
	}
	if (open_conf == "vnts_cmd") {
		get_vnts_cmd();
		console.log("vnts_cmd")
	}
	if (open_conf == "vnts_fingerprint") {
		get_vnts_fingerprint();
		console.log("vnts_fingerprint")
	}
	if (open_conf == "vnt_log") {
		get_vnt_log();
	}
	if (open_conf == "vnts_log") {
		get_vnts_log();
	}
	$("#" + open_conf).fadeIn(200);
}
function close_conf(close_conf) {
	$("#" + close_conf).fadeOut(200);
}
function toggle_func() {
	E("simple_table").style.display = "";
	E("conf_table").style.display = "none";
	E("customize_conf_table").style.display = "none";
	$('.show-btn1').addClass('active');
	$(".show-btn1").click(
		function() {
			$('.show-btn1').addClass('active');
			$('.show-btn2').removeClass('active');
			$('.show-btn3').removeClass('active');
			E("simple_table").style.display = "";
			E("conf_table").style.display = "none";
			E("customize_conf_table").style.display = "none";
			$('.apply_gen').show();
			
		}
	);
	$(".show-btn2").click(
		function() {
			$('.show-btn1').removeClass('active');
			$('.show-btn2').addClass('active');
			$('.show-btn3').removeClass('active');
			E("simple_table").style.display = "none";
			E("conf_table").style.display = "none";
			E("customize_conf_table").style.display = "";
			$('.apply_gen').show();
			
		}
	);
	$(".show-btn3").click(
		function() {
			$('.show-btn1').removeClass('active');
			$('.show-btn2').removeClass('active');
			$('.show-btn3').addClass('active');
			E("simple_table").style.display = "none";
			E("conf_table").style.display = "";
			E("customize_conf_table").style.display = "none";
			$('.apply_gen').hide();
		}
	);
	
	$("#vnt_ipmode").change(
		function(){
		if(E("vnt_ipmode").value == "static"){
			E("static_ip").style.display = "";
		}else{
		    E("static_ip").style.display = "none";
		}
	});
}

//网页重载时更新显示样式
function update_visibility(){
	if( db_vnt["vnt_ipmode"] == "static"){
		if (E("static_ip")) E("static_ip").style.display = "";
	}else{
		if (E("static_ip")) E("static_ip").style.display = "none";
	}
}
document.addEventListener('DOMContentLoaded', function() {
    var vntEnableCheckbox = document.getElementById('vnt_enable');
    var vntActionBtn = document.getElementById('vnt_action_btn');
    var feedbackMessage = document.createElement('div'); // 创建一个新的 div 元素用于显示反馈消息
    feedbackMessage.style.display = 'none'; // 初始时隐藏反馈消息
    feedbackMessage.style.marginLeft = '10px'; // 设置反馈消息的左边距
    feedbackMessage.style.transition = 'opacity 0.5s ease'; // 添加渐变效果
	// 将反馈消息添加到按钮旁边的父元素中
    vntActionBtn.parentNode.appendChild(feedbackMessage);
    // 根据复选框的初始状态设置按钮文本
    updateButtonLabel(vntEnableCheckbox.checked);

    // 监听复选框状态变化
    vntEnableCheckbox.addEventListener('change', function() {
        updateButtonLabel(this.checked);
    });

    // 监听按钮点击事件
    vntActionBtn.addEventListener('click', function() {
        var buttonText = vntActionBtn.textContent.trim();
        if (buttonText === '重启') {
            restate(); // 执行重启函数
        } else if (buttonText === '更新') {
            update(); // 执行更新函数
        }
    });

    function updateButtonLabel(isChecked) {
        // 根据复选框的状态更新按钮文本
        vntActionBtn.textContent = isChecked ? '重启' : '更新';
    }

    function restate() {
        // 执行重启
        var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["restartvnt"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
			 	showFeedback('重启执行成功');
			}
		}
	});
    }

    function update() {
        // 执行更新
        var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["updatevnt"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
				showFeedback('更新执行成功');
			}
		}
	});
    }
	function showFeedback(message) {
        feedbackMessage.textContent = message; // 设置反馈消息的文本内容
        feedbackMessage.style.display = 'block'; // 显示反馈消息
        setTimeout(function() {
            feedbackMessage.style.opacity = '0'; // 在3秒后将反馈消息的透明度设为0
            setTimeout(function() {
                feedbackMessage.style.display = 'none'; // 在渐变结束后隐藏反馈消息
                feedbackMessage.style.opacity = '1'; // 重置透明度
            }, 500); // 0.5秒后隐藏反馈消息
        }, 3000); // 3秒后开始隐藏反馈消息
    }
});


document.addEventListener('DOMContentLoaded', function() {
    var vntsEnableCheckbox = document.getElementById('vnts_enable');
    var vntsActionBtn = document.getElementById('vnts_action_btn');
    var sfeedbackMessage = document.createElement('div'); 
    sfeedbackMessage.style.display = 'none'; 
    sfeedbackMessage.style.marginLeft = '10px'; 
    sfeedbackMessage.style.transition = 'opacity 0.5s ease'; 
    vntsActionBtn.parentNode.appendChild(sfeedbackMessage);

    // 根据复选框的初始状态设置按钮文本
    updateButtonLabel(vntsEnableCheckbox.checked);

    // 监听复选框状态变化
    vntsEnableCheckbox.addEventListener('change', function() {
        updateButtonLabel(this.checked);
    });
    // 监听按钮点击事件
    vntsActionBtn.addEventListener('click', function() {
        var buttonText = vntsActionBtn.textContent.trim();
        if (buttonText === '重启') {
            restates(); // 执行重启函数
        } else if (buttonText === '更新') {
            updates(); // 执行更新函数
        }
    });
    function updateButtonLabel(isChecked) {
        // 根据复选框的状态更新按钮文本
        vntsActionBtn.textContent = isChecked ? '重启' : '更新';
    }
    function restates() {
    // 执行重启
        var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["restartvnts"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
				showFeedbacks('重启执行成功');
			}
		}
	});
    }

    function updates() {
    // 执行更新
        var uid = parseInt(Math.random() * 100000000);
	var postData = {"id": uid, "method": "vnt_config.sh", "params": ["updatevnts"], "fields": db_vnt };
	$.ajax({
		url: "/_api/",
		cache: false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData),
		success: function(response) {
			if (response.result == uid){
				showFeedbacks('更新执行成功');
			}
		}
	});
    }
   function showFeedbacks(message) {
        sfeedbackMessage.textContent = message; 
        sfeedbackMessage.style.display = 'block'; 
        setTimeout(function() {
            sfeedbackMessage.style.opacity = '0'; 
            setTimeout(function() {
                sfeedbackMessage.style.display = 'none';
                sfeedbackMessage.style.opacity = '1'; 
            }, 500); 
        }, 3000); 
    }
});
function openssHint(itemNum) {
	statusmenu = "";
	width = "350px";
	if (itemNum == 0) {
		statusmenu = "开启vnt-cli客户端选项,更新按钮为在线更新客户端程序版本，重启会同时重启客户端服务端";
		_caption = "客户端服务说明";
	} else if (itemNum == 1) {
		statusmenu = "需要连接的vnts服务器的IP:端口。留空，默认使用内置的公共服务器。<br>协议支持使用tcp://和ws://和wss://,默认为udp://";
		_caption = "vnts服务器地址";
	} else if (itemNum == 2) {
		statusmenu = "自定义打洞stun服务器，使用stun服务探测客户端NAT类型，不同类型有不同的打洞策略，已内置谷歌 QQ 可不填<br>多个stun服务器地址，请使用英文|进行分隔";
		_caption = "stun服务器地址";
	} else if (itemNum == 3) {
		statusmenu = " 这是必填项！一个虚拟局域网的标识，连接同一服务器时，相同VPN名称的设备才会组成一个局域网（这是 -k 参数）<br><font color='#F46'>注意：</font>某些特殊字符的密码，可能会无法验证。";
		_caption = " 客户端 token ";
	} else if (itemNum == 4) {
		statusmenu = "显示程序的进程状态及 pid";
		_caption = "运行状态";
	} else if (itemNum == 6) {
		statusmenu = "当前设备网卡生成的虚拟的IP地址，由服务器自动分配还是手动指定";
		_caption = "接口模式";
	} else if (itemNum == 7) {
		statusmenu = "手动指定虚拟IP地址，请输入有效的IP地址，若服务端指定了虚拟网段，则这里的IP地址也要和服务器相同网段";
		_caption = " 指定虚拟IP地址";
	} else if (itemNum == 8) {
		statusmenu = "设定当前设备的硬件ID标识，注意：每台客户端的设备ID不能相同！";
		_caption = " 设备ID";
	} else if (itemNum == 9) {
		statusmenu = "指定当前设备的名称，方便在虚拟局域网里区分哪个客户端是哪个设备";
		_caption = "设备名称";
	} else if (itemNum == 10) {
		statusmenu = "指定对端可以访问当前局域网里设备的网段<br>例如：当前设备的lan网段为192.168.2.1 则填写192.168.2.0/24 <br> 多个网段请使用英文的|分隔 192.168.2.0/24|192.168.3.0/24 <br>开放所有网段 请填 0.0.0.0/0";
		_caption = "本地网段";
	} else if (itemNum == 11) {
		statusmenu = "指定访问对端局域网设备，如对端lan IP是192.168.4.1 虚拟IP是 10.26.0.4 <br>则填192.168.4.0/24,10.26.0.4 多个网段也使用英文|分隔 <br>例如 192.168.4.0/24,10.26.0.4|192.168.5.0/24,10.26.0.5";
		_caption = "对端网段";
        } else if (itemNum == 12) {
		statusmenu = "开启前向纠错 (FEC)。在网络质量较差（丢包率高）的环境下，可通过消耗更多的带宽来降低丢包影响，提升传输的稳定性和成功率。";
		_caption = "开启前向纠错";
	} else if (itemNum == 13) {
		statusmenu = "设置作为流量出口的网卡，错误绑定网卡可能会导致无法上网，恢复不绑定即可";
		_caption = "指定出口节点网卡";
	} else if (itemNum == 14) {
		statusmenu = "选择只使用IPV4进行连接，还是只使用IPV6进行连接，默认都使用";
		_caption = "地址类型选择";
	} else if (itemNum == 15) {
		statusmenu = "指定本地监听的端口组，多个端口使用逗号分隔，多个端口可以分摊流量，增加并发，tcp会监听端口组的第一个端口，用于tcp直连<br>例1：‘12345,12346,12347’ 表示udp监听12345、12346、12347这三个端口，tcp监听12345端口<br>例2：‘0,0’ 表示udp监听两个未使用的端口，tcp监听一个未使用的端口";
		_caption = "客户端打洞端口";
	} else if (itemNum == 16) {
		statusmenu = "设置虚拟网卡的mtu值，大多数情况下（留空）使用默认值效率会更高，也可根据实际情况进行微调，默认值：不加密1450，加密1410 ";
		_caption = "MTU值";
	} else if (itemNum == 17) {
		statusmenu = "定时执行操作。<font color='#F46'>检查：</font>检查vnt的进程是否存在，若不存在则重新启动；<font color='#F46'>启动：</font>重新启动vnt进程，而不论当时是否在正常运行。重新启动服务会导致活动中的连接短暂中断.<br><font color='#F46'>注意：</font>填写内容为 0 关闭定时功能！<br/>建议：选择分钟填写“60的因数”【1、2、3、4、5、6、10、12、15、20、30、60】，选择小时填写“24的因数”【1、2、3、4、6、8、12、24】。";
		_caption = "定时功能";
	} else if (itemNum == 19) {
		statusmenu = "设定客户端之间的加密连接使用的加密模式<br>默认off不加密，通常情况aes_gcm安全性高、aes_ecb性能更好，在低性能设备上aes_ecb/chacha20_poly1305/chacha20/xor速度最快<br>注意：xor为数据混淆，并不是一种强大的加密算法，易被破解，因此不适合用于真正的加密需求";
		_caption = " 加密模式";
	} else if (itemNum == 20) {
		statusmenu = "选择加密模式后，填写的加密密钥，启用后所有客户端必须填写一样的密钥才能连接";
		_caption = "加密密钥";
	} else if (itemNum == 21) {
		statusmenu = "设定当前程序的存放路径，确保填写完整的路径及客户端或服务端的文件名";
		_caption = " 程序路径";
	} else if (itemNum == 22) {
		statusmenu = "内置的代理较为简单，而且一般来说直接使用网卡NAT转发性能会更高,所以默认开启IP转发关闭内置的ip代理";
		_caption = " IP转发";
	} else if (itemNum == 23) {
		statusmenu = "<strong>vnt-cli客户端设置</strong>：可以单独使用客户端，无需启用服务端，客户端程序内置有公共服务器<br/><strong>vnts服务端设置</strong>：支持自建服务器，启用服务端后所有客户端填此设备的IP或者域名: 端口（须为公网IP，新版支持V4和V6公网）";
		_caption = "客户端服务端选择";
	} else if (itemNum == 24) {
		statusmenu = "用服务端通信的数据加密，采用rsa+aes256gcm加密客户端和服务端之间通信的数据可以避免token泄漏、中间人攻击，<br>这是服务器和客户端之间的加密";
		_caption = " 客户端与服务端之间的加密";
	} else if (itemNum == 25) {
		statusmenu = "证书安全校验模式，支持填入指纹(finger:xxx)或 standard，留空则跳过验证(skip)。<br>开启可增加安全性，但会损耗一部分性能。注意：如果服务端开启校验，则客户端也必须开启。";
		_caption = " 证书安全校验";
	} else if (itemNum == 26) {
		statusmenu = "p2p(直连): 默认模式，优先打洞直连，如果打洞失败再走服务器转发<br>转发(relay): 仅中继转发模式，会禁止打洞/p2p直连，所有数据只使用服务器转发<br>在网络环境很差时，不使用p2p只使用服务器中继转发效果可能更好";
		_caption = "连接模式";
	} else if (itemNum == 27) {
		statusmenu = "开启 QUIC 优化传输。启用后，底层将尝试使用基于 QUIC 协议的优化通道传输数据，以改善弱网环境下的延迟和稳定性。";
		_caption = "优化传输";
	} else if (itemNum == 28) {
		statusmenu = "指定虚拟网卡名称，默认tun模式使用vnt-tun<br>多开时需要使用不同的网卡名";
		_caption = "网卡名称";
	} else if (itemNum == 29) {
		statusmenu = "开启vnts服务端选项，更新按钮为在线更新服务端程序版本，重启会同时重启客户端服务端";
		_caption = "服务端服务说明";
	} else if (itemNum == 30) {
		statusmenu = "查看程序的信息和运行日志";
		_caption = "运行日志";
	} else if (itemNum == 31) {
		statusmenu = "设定白名单token，若填写只有这指定的token名称才能连接，不填则所有客户端都可以连接<br>多个token请使用英文的|进行分隔";
		_caption = "服务器token";
	} else if (itemNum == 32) {
		statusmenu = "设定服务器的监听端口，客户端将使用此端口连接服务器";
		_caption = "服务器端口";
	} else if (itemNum == 33) {
		statusmenu = "设定服务器分配的虚拟IP网段，默认10.26.0.0  ，若设定则客户端必须填写此网段才能连接";
		_caption = "服务器DHCP网关";
	} else if (itemNum == 34) {
		statusmenu = "设定服务器的子网掩码";
		_caption = "服务器网络掩码";
	} else if (itemNum == 35) {
		statusmenu = "这里可以上传以<font color='#F46'>.tar.gz</font>结尾的程序压缩包会自动解压<br>也可以上传<font color='#F46'>vnt-cli</font> 或 <font color='#F46'>vnts</font> 二进制程序文件<br>已有的程序将会被替换<br>客户端程序文件名请包含<font color='#F46'>vnt-cli</font>  服务端文件名请包含<font color='#F46'>vnts</font><br>上传二进制文件的话文件名必须为<font color='#F46'>vnt-cli</font>  服务端名必须为<font color='#F46'>vnts</font>";
		_caption = "上传程序选择文件";
	} else if (itemNum == 36) {
		statusmenu = "启用服务端的WEB界面，图形化显示所有客户端信息";
		_caption = "WEB管理界面";
	} else if (itemNum == 37) {
		statusmenu = "设定WEB管理界面的访问端口，不能与服务端的监听端口相同！";
		_caption = "WEB管理界面端口";
	} else if (itemNum == 38) {
		statusmenu = "WEB管理界面登录的用户名，不设置默认为admin";
		_caption = "WEB管理界面用户名";
	} else if (itemNum == 39) {
		statusmenu = "WEB管理界面登录的密码，不设置默认为admin";
		_caption = "WEB管理界面密码";
	} else if (itemNum == 40) {
		statusmenu = "开启后在外网将可以访问WEB管理界面，为安全起见，建议设置复杂的用户名和密码，定期更换，避免泄露";
		_caption = "外网访问WEB";
	} else if (itemNum == 41) {
		statusmenu = "端口映射，格式为：协议://本地监听地址-目标虚拟IP-目标映射地址。可以设置多个映射地址，以换行或逗号分隔，例如：<font color='#F46'>tcp://0.0.0.0:81-10.26.0.10-10.26.0.10:80</font>";
		_caption = "端口映射";
	} else if (itemNum == 42) {
		statusmenu = "启用压缩，v2 仅支持开启/关闭 lz4 压缩。开启压缩后，如果数据包长度大于等于128，则会使用压缩，否则还是会按原数据发送。";
		_caption = "数据压缩";
	} else if (itemNum == 43) {
		statusmenu = "禁用虚拟网卡。开启后 VNT 只做流量出口或端口映射，不再创建本地的 tun 设备。";
		_caption = "禁用虚拟网卡";
	} else if (itemNum == 44) {
		statusmenu = "指定隧道通信端口，用于 P2P 通信。默认为 0（系统自动分配）。如果您有特殊网络需求（如固定 NAT 映射），可以手动指定端口。";
		_caption = "隧道通信端口";
	} else if (itemNum == 45) {
		statusmenu = "是否允许本节点作为端口映射出口。开启后，虚拟局域网内的其他设备才可以使用本设备的虚拟 IP 作为端口映射中的'目标虚拟IP'进行流量转发。";
		_caption = "允许映射出口";
	} else if (itemNum == 50) {
		statusmenu = "设定客户端连接服务端时的验证密码（Server Token），非空时所有接入此服务端的客户端必须持有相同的密码。";
		_caption = "连接验证密码";
	} else if (itemNum == 52) {
		statusmenu = "IP 租约回收失效的时长（以秒为单位），默认 86400 秒（24小时）。当客户端离线时长超过此设定值后，其分配到的虚拟 IP 将被服务端回收。";
		_caption = "IP 租约失效时长";
	} else if (itemNum == 53) {
		statusmenu = "启用后服务端会将分配 of IP、互联节点路由等状态信息持久化保存至本地 SQLite 数据库文件中，避免因重启服务导致状态丢失。";
		_caption = "本地数据持久化";
	} else if (itemNum == 54) {
		statusmenu = "自建服务端 TCP 协议的监听绑定地址与端口，留空则不开启 TCP 协议服务。默认：0.0.0.0:29872。";
		_caption = "TCP 监听绑定";
	} else if (itemNum == 55) {
		statusmenu = "自建服务端 QUIC 协议的监听绑定地址与端口，留空则不开启 QUIC 协议服务。默认：0.0.0.0:29872。";
		_caption = "QUIC 监听绑定";
	} else if (itemNum == 56) {
		statusmenu = "自建服务端 WebSocket/WSS 协议的监听绑定地址与端口，留空则不开启 WS 协议服务。默认：0.0.0.0:29872。";
		_caption = "WS 监听绑定";
	} else if (itemNum == 57) {
		statusmenu = "自建服务端 TLS 加密证书的公钥文件存放路径。如果不填写，服务端会自动在内存中生成临时的自签名证书。建议生产环境配置有效证书以避免安全性告警。";
		_caption = "TLS 证书文件路径";
	} else if (itemNum == 58) {
		statusmenu = "自建服务端 TLS 加密证书的私钥文件存放路径，配合证书公钥文件一同配置使用。";
		_caption = "TLS 私钥文件路径";
	} else if (itemNum == 59) {
		statusmenu = "多服务端级联互联时，用于级联通信的 QUIC/UDP 协议监听绑定端口。不启用自建服务端互联则留空。";
		_caption = "级联监听绑定";
	} else if (itemNum == 60) {
		statusmenu = "配置其他互联服务端的通信地址（例如 1.2.3.4:29873），多个地址可用换行、逗号或 | 进行分隔。不进行级联级互联请留空。";
		_caption = "互联服务器列表";
	} else if (itemNum == 61) {
		statusmenu = "在服务端全局指定网络编号到特定对端网关局域网段的映射关系。格式为: 网络编号=目标网段（如 net1=192.168.1.0/24）。每行输入一条，多个可用换行或逗号分隔。";
		_caption = "局域网段网关指向";
	} 

	return overlib(statusmenu, OFFSETX, -160, LEFT, STICKY, WIDTH, 'width', CAPTION, _caption, CLOSETITLE, '');
	var tag_name = document.getElementsByTagName('a');
	for (var i = 0; i < tag_name.length; i++)
		tag_name[i].onmouseout = nd;
	if (helpcontent == [] || helpcontent == "" || hint_array_id > helpcontent.length)
		return overlib('<#defaultHint#>', HAUTO, VAUTO);
	else if (hint_array_id == 0 && hint_show_id > 21 && hint_show_id < 24)
		return overlib(helpcontent[hint_array_id][hint_show_id], FIXX, 270, FIXY, 30);
	else {
		if (hint_show_id > helpcontent[hint_array_id].length)
			return overlib('<#defaultHint#>', HAUTO, VAUTO);
		else
			return overlib(helpcontent[hint_array_id][hint_show_id], HAUTO, VAUTO);
	}
}
function upload_bin() {
    var filename = $("#file").val();
    if (!filename) {
        alert("没有选择文件！");
        return false;
    }
    filename = filename.split('\\');
    filename = filename[filename.length - 1];
    document.getElementById('file_info').style.display = "none";
    var formData = new FormData();
    formData.append(filename, $('#file')[0].files[0]);

    $.ajax({
        url: '/_upload',
        type: 'POST',
        cache: false,
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            // 上传成功后的处理
            var vntbin = {
                "vnt_name": filename,
            };
            
            install_now(vntbin);
        },
        error: function(xhr, status, error) {
            // 上传失败后的处理
            alert("上传失败: " + error);
        }
    });
}

function install_now(vntbin) {
	var id = parseInt(Math.random() * 100000000);
	var postData = {"id": id, "method": "vnt_tar_install.sh", "params": [], "fields": vntbin};
	$.ajax({
		type: "POST",
		url: "/_api/",
		data: JSON.stringify(postData),
		dataType: "json",
		success: function(response) {
			if(response.result == id){
			    document.getElementById('file_info').style.display = "block";
				get_installog(1);
			}
		}
	});
}
var _responseLen;
function get_installog(s) {
	var retArea = E("soft_log_area");
	$.ajax({
		url: '/_temp/installvnt_log.txt',
		type: 'GET',
		dataType: 'text',
		cache: false,
		success: function(response) {
			if (response.search("LBL8603") != -1) {
				retArea.value = response.myReplace("LBL8603", " ");
				retArea.scrollTop = retArea.scrollHeight;
				if (s) {
					setTimeout("window.location.reload()", 3000);
				}
				return true;
			}
			if (_responseLen == response.length) {
				noChange++;
			} else {
				noChange = 0;
			}
			if (noChange > 4000) {
				//tabSelect("app1");
				return false;
			} else {
				setTimeout("get_installog(1);", 1000);
			}
			retArea.value = response;
			retArea.scrollTop = retArea.scrollHeight;
			_responseLen = response.length;
		},
		error: function(xhr, status, error) {
			if (s) {
				E("soft_log_area").value = "没有找到上传记录";
			}
		}
	});
}
</script>
</head>
<body onload="initial();">
<div id="TopBanner"></div>
<div id="Loading" class="popup_bg"></div>
<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>
<form method="POST" name="form" action="/applydb.cgi?p=vnt" target="hidden_frame">
<input type="hidden" name="current_page" value="Module_vnt.asp"/>
<input type="hidden" name="next_page" value="Module_vnt.asp"/>
<input type="hidden" name="group_id" value=""/>
<input type="hidden" name="modified" value="0"/>
<input type="hidden" name="action_mode" value=""/>
<input type="hidden" name="action_script" value=""/>
<input type="hidden" name="action_wait" value="5"/>
<input type="hidden" name="first_time" value=""/>
<input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>"/>
<input type="hidden" name="firmver" value="<% nvram_get("firmver"); %>"/>
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
                        <table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3"  class="FormTitle" id="FormTitle">
                            <tr>
                                <td bgcolor="#4D595D" colspan="3" valign="top">
                                    <div>&nbsp;</div>
                                    <div style="float:left;" class="formfonttitle">VNT v2.0  异地组网、内网穿透工具</div>
                                    <div style="float:right; width:15px; height:25px;margin-top:10px"><img id="return_btn" onclick="reload_Soft_Center();" align="right" style="cursor:pointer;position:absolute;margin-left:-30px;margin-top:-25px;" title="返回软件中心" src="/images/backprev.png" onMouseOver="this.src='/images/backprevclick.png'" onMouseOut="this.src='/images/backprev.png'"></img></div>
                                    <div style="margin:30px 0 10px 5px;" class="splitLine"></div>
                                    <div class="formfontdesc">VNT 是一个简便高效的异地组网、内网穿透工具。【仓库链接：<a href="https://github.com/vnt-dev/vnt" target="_blank"><em><u>Github</u></em></a>】【使用文档：<a href="https://rustvnt.com" target="_blank"><em><u>官网</u></em></a>&nbsp;&nbsp;<a href="https://github.com/vnt-dev/vnt/blob/main/vnt-cli/README.md" target="_blank"><em><u>客户端</u></em></a>&nbsp;&nbsp;<a href="https://github.com/vnt-dev/vnts?tab=readme-ov-file#vnts" target="_blank"><em><u>服务端</u></em></a>】【安卓端GUI：<a href="https://github.com/vnt-dev/VntApp" target="_blank"><em><u>VntApp</u></em></a>】【QQ群：<a href="http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=o3Rr9xUWwAAnV9TkU_Nyj3yHNLs9k5F5&authKey=l1FKvqk7%2F256SK%2FHrw0PUhs%2Bar%2BtKYx0pLb7aiwBN9%2BKBCY8sOzWWEqtl4pdXAT7&noverify=0&group_code=1034868233" target="_blank"><em><u>vnt组网交流群</u></em></a>】<br/><i>  点击下方参数设置的文字，可查看帮助信息  </i></div>
                                    <div id="tablet_show">
                                        <table style="margin:10px 0px 0px 0px;border-collapse:collapse" width="100%" height="37px">
                                            <tr width="235px">
                                             <td colspan="4" cellpadding="0" cellspacing="0" style="padding:0" border="1" bordercolor="#000">
                                               <input id="show_btn1" class="show-btn1" style="cursor:pointer" type="button" value="客户端"/>
                                               <input id="show_btn2" class="show-btn2" style="cursor:pointer" type="button" value="服务端"/>
											   <input id="show_btn3" class="show-btn3" style="cursor:pointer" type="button" value="上传程序"/>
                                             </td>
                                             </tr>
                                        </table>
                                    </div>

                                    <div id="simple_table">
                                    <table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" style="box-shadow: 3px 3px 10px #000;margin-top: 0px;">
                                        <thead>
                                            <tr>
                                            <td colspan="2"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(23)">vnt-cli 客户端设置</a></td>
                                            </tr>
                                        </thead>
										 <tr id="vnt-cli">
                                            <th>
                                                <label><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(0)">开启客户端</a></label>
                                            </th>
                                            <td colspan="2">
                                                <div class="switch_field" style="display:table-cell;float: left;">
                                                    <label for="vnt_enable">
                                                        <input id="vnt_enable" class="switch" type="checkbox" style="display: none;">
                                                        <div class="switch_container" >
                                                            <div class="switch_bar"></div>
                                                            <div class="switch_circle transition_style">
                                                                <div></div>
                                                            </div>
                                                        </div>
                                                    </label>
                                                </div>
												<div>
            <button id="vnt_action_btn" class="vnt_custom_btn"></button>
        </div>
                                            </td>
                                        </tr>
                                        <tr id="vnt_status">
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(4)">运行状态</th>
                                            <td><span id="status1">获取中...</span>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(17)">定时功能(<i>0为关闭</i>)</a></th>
                                            <td>
                                                每 <input type="text" oninput="this.value=this.value.replace(/[^\d]/g, '')" id="vnt_cron_time" name="vnt_cron_time" class="input_3_table" maxlength="2" value="0" placeholder="" />
                                                <select id="vnt_cron_hour_min" name="vnt_cron_hour_min" style="width:60px;margin:3px 2px 0px 2px;" class="input_option">
                                                    <option value="min">分钟</option>
                                                    <option value="hour">小时</option>
                                                </select> 
                                                    <select id="vnt_cron_type" name="vnt_cron_type" style="width:60px;margin:3px 2px 0px 2px;" class="input_option">
                                                        <option value="watch">检查</option>
                                                        <option value="start">重启</option>
                                                    </select> 一次服务
                                            </td>
                                        </tr>

                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(30)">设备信息和日志</th>
                                            <td>
                                                <a type="button" class="info_btn" style="cursor:pointer" href="javascript:void(0);" onclick="open_conf('vnt_info');" >当前设备信息</a>&nbsp;
												<a type="button" class="info_btn" style="cursor:pointer" href="javascript:void(0);" onclick="open_conf('vnt_all');" >所有设备信息</a>&nbsp;
												<a type="button" class="info_btn" style="cursor:pointer" href="javascript:void(0);" onclick="open_conf('vnt_list');" >所有设备列表</a><br><br>
												<a type="button" class="info_btn" style="cursor:pointer" href="javascript:void(0);" onclick="open_conf('vnt_route');" >路由转发信息</a>&nbsp;
												<a type="button" class="info_btn" style="cursor:pointer" href="javascript:void(0);" onclick="open_conf('vnt_cmd');" >状态参数信息</a>&nbsp;
                                                <a type="button" class="info_btn" style="cursor:pointer" href="javascript:void(0);" onclick="open_conf('vnt_log');" >程序运行日志</a>
                                            </td>
                                        </tr>
										<tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(3)">虚拟网络 Token (network_code)</a></th>
                                            <td>
                                                <input type="password" name="vnt_token" id="vnt_token" title="虚拟网络Token（必填）" class="input_ss_table" autocomplete="new-password" autocorrect="off" autocapitalize="off" maxlength="64" value="" onBlur="switchType(this, false);" onFocus="switchType(this, true);" placeholder="必填，虚拟网络 Token" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(1)">服务器地址 (server)</a></th>
                                            <td>
                                                <textarea type="text" class="input_ss_table" value="" id="vnt_serveraddr" title="例如: tcp://127.0.0.1:29872。多个地址以英文逗号 '',''、''|'' 或换行分隔" name="vnt_serveraddr" placeholder="例如: tcp://127.0.0.1:29872。多个地址以英文逗号 ','、'|' 或换行分隔" style="height: 50px; font-family:'Courier New', Courier, mono; font-size: 11px;"></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(6)">接口模式</a></th>
                                            <td>
                                                <select id="vnt_ipmode" name="vnt_ipmode" style="width:165px;margin:0px 0px 0px 2px;" value="dhcp" class="input_option" >
                                                    <option value="dhcp">动态分配 (DHCP)</option>
                                                    <option value="static">静态指定 (Static)</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr id="static_ip" style="display: none;">
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(7)">指定虚拟 IP (ip)</a></th>
                                            <td>
                                                <input type="text" class="input_ss_table" value="" id="vnt_static_ip" title="指定当前客户端虚拟IP，例如: 10.26.0.10" name="vnt_static_ip" placeholder="选择静态指定时必填，请输入有效的IP地址！"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(8)">硬件设备 ID (device_id)</a></th>
                                            <td>
                                                <input type="text" class="input_ss_table" value="" id="vnt_desvice_id" title="设备物理硬件ID，例如: f3e9f8f8-7aaa-411f-8790-0173c6e8cf58。注意：每台设备ID不能相同！" name="vnt_desvice_id" placeholder="选填，建议和虚拟IP地址填写一致" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(9)">设备别名 (device_name)</a></th>
                                            <td>
                                                <input type="text" class="input_ss_table" value="" id="vnt_desvice_name" title="设备别名，用于标识此客户端，例如: Merlin_Router" name="vnt_desvice_name" placeholder="选填，设备别名，例如: Merlin_Router" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(20)">数据加密密码 (password)</a></th>
                                            <td>
                                                <input type="password" name="vnt_key" id="vnt_key" title="端到端数据加密密钥（选填）" class="input_ss_table" autocomplete="new-password" autocorrect="off" autocapitalize="off" value="" onBlur="switchType(this, false);" onFocus="switchType(this, true);" placeholder="选填，端到端加密密码，留空则不开启加密" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>
                                                <label><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(27)">开启优化传输 (rtx)</a></label>
                                            </th>
                                            <td colspan="2">
                                                <div class="switch_field" style="display:table-cell;float: left;">
                                                    <label for="vnt_first_latency_enable">
                                                        <input id="vnt_first_latency_enable" class="switch" type="checkbox" style="display: none;">
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
                                            <th>
                                                <label><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(42)">开启 LZ4 数据压缩 (compress)</a></label>
                                            </th>
                                            <td colspan="2">
                                                <div class="switch_field" style="display:table-cell;float: left;">
                                                    <label for="vnt_compressor">
                                                        <input id="vnt_compressor" class="switch" type="checkbox" style="display: none;">
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
                                            <th>
                                                <label><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(12)">开启前向纠错 (fec)</a></label>
                                            </th>
                                            <td colspan="2">
                                                <div class="switch_field" style="display:table-cell;float: left;">
                                                    <label for="vnt_fec">
                                                        <input id="vnt_fec" class="switch" type="checkbox" style="display: none;">
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
                                            <th>
                                                <label><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(45)">允许本节点作为映射出口 (allow_mapping)</a></label>
                                            </th>
                                            <td colspan="2">
                                                <div class="switch_field" style="display:table-cell;float: left;">
                                                    <label for="vnt_allow_mapping">
                                                        <input id="vnt_allow_mapping" class="switch" type="checkbox" style="display: none;">
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
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(28)">虚拟网卡名称 (tun_name)</a></th>
                                            <td>
                                                <input type="text" class="input_ss_table" value="" id="vnt_tun_name" title="虚拟网卡名称，默认: vnt-tun" name="vnt_tun_name" placeholder="默认: vnt-tun" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>
                                                <label><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(43)">禁用虚拟网卡 (no_tun)</a></label>
                                            </th>
                                            <td colspan="2">
                                                <div class="switch_field" style="display:table-cell;float: left;">
                                                    <label for="vnt_no_tun">
                                                        <input id="vnt_no_tun" class="switch" type="checkbox" style="display: none;">
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
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(44)">隧道通信端口 (tunnel_port)</a></th>
                                            <td>
                                                <input type="text" oninput="this.value=this.value.replace(/[^\d]/g, '')" class="input_ss_table" id="vnt_tunnel_port" title="隧道端口，用于P2P通信 (默认为0，自动分配)" name="vnt_tunnel_port" placeholder="默认为0 (自动分配)" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(16)">最大传输单元 (MTU)</a></th>
                                            <td>
                                                <input type="text" oninput="this.value=this.value.replace(/[^\d]/g, '')" class="input_ss_table" id="vnt_mtu" title="最大传输单元（MTU）。留空使用自动默认值" name="vnt_mtu" placeholder="默认自动" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(25)">证书安全校验 (cert_mode)</a></th>
                                            <td>
                                                <input type="text" class="input_ss_table" id="vnt_cert_mode" title="留空则跳过验证(skip)，或输入standard，或输入finger:指纹" name="vnt_cert_mode" placeholder="留空跳过验证，或输入 finger:xxxx..." />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>
                                                <label><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(22)">开启 IP 转发 (no_nat)</a></label>
                                            </th>
                                            <td colspan="2">
                                                <div class="switch_field" style="display:table-cell;float: left;">
                                                    <label for="vnt_proxy_enable">
                                                        <input id="vnt_proxy_enable" class="switch" type="checkbox" style="display: none;">
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
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(26)">连接模式 (no_punch)</a></th>
                                            <td>
                                                <select id="vnt_relay_enable" name="vnt_relay_enable" style="width:165px;margin:0px 0px 0px 2px;" class="input_option">
                                                    <option value="p2p" selected>仅打洞 (P2P)</option>
                                                    <option value="relay">仅限转发 (Relay)</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(41)">本地端口映射 (port_mapping)</a></th>
                                            <td>
                                                <textarea type="text" class="input_ss_table" id="vnt_mapping" title="本地端口映射，例如: tcp:0.0.0.0:80->10.26.0.10:80。一行输入一条，以换行或逗号分隔" name="vnt_mapping" placeholder="选填，格式例如: tcp:0.0.0.0:80->10.26.0.10:80。一行输入一条，以换行或逗号分隔" style="height: 50px; font-family:'Courier New', Courier, mono; font-size: 11px;"></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(10)">本地子网对外宣告 (output)</a></th>
                                            <td>
                                                <textarea type="text" class="input_ss_table" id="vnt_localadd" title="宣告本地局域网段，例如: 192.168.50.0/24。多个网段以逗号或换行分隔" name="vnt_localadd" placeholder="选填，宣告本地局域网段，例如: 192.168.50.0/24。多个网段以英文逗号 ','、'|' 或换行分隔" style="height: 50px; font-family:'Courier New', Courier, mono; font-size: 11px;"></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(11)">目标局域网路由转发 (input)</a></th>
                                            <td>
                                                <textarea type="text" class="input_ss_table" id="vnt_peeradd" title="目标局域网路由转发，例如: 192.168.60.0/24,10.26.0.2。多个以逗号或换行分隔" name="vnt_peeradd" placeholder="选填，添加到对端局域网的路由，例如: 192.168.123.0/24。多个网段以英文逗号 ','、'|' 或换行分隔" style="height: 50px; font-family:'Courier New', Courier, mono; font-size: 11px;"></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(2)">STUN 服务探测地址</a></th>
                                            <td>
                                                <textarea type="text" class="input_ss_table" id="vnt_stunaddr" title="STUN服务器地址，例如: stun.qq.com:3478。多个以逗号或换行分隔" name="vnt_stunaddr" placeholder="选填，STUN地址例如: stun.qq.com:3478。多个地址以英文逗号 ','、'|' 或换行分隔" style="height: 50px; font-family:'Courier New', Courier, mono; font-size: 11px;"></textarea>
                                            </td>
                                        </tr>
                                    </table>
                                    </div>
                                    <div id="customize_conf_table">
                                    <table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" style="box-shadow: 3px 3px 10px #000;margin-top: 0px;">
                                        <thead>
                                            <tr>
                                            <td colspan="2"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(23)">vnts 服务器设置</a></td>
                                            </tr>
                                        </thead>
                                           <tr id="vnts">
                                            <th>
                                                <label><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(29)">开启服务器</a></label>
                                            </th>
                                            <td colspan="2">
                                                <div class="switch_field" style="display:table-cell;float: left;">
                                                    <label for="vnts_enable">
                                                        <input id="vnts_enable" class="switch" type="checkbox" style="display: none;">
                                                        <div class="switch_container" >
                                                            <div class="switch_bar"></div>
                                                            <div class="switch_circle transition_style">
                                                                <div></div>
                                                            </div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <a> <button id="vnts_action_btn" class="vnt_custom_btn"></button></a>
                                                <a type="button" class="web_btn" style="cursor:pointer; display: none;padding-top:2px;margin-left:6px;margin-top:0px;float: right; position: relative; right: 60%;" href="javascript:void(0);" onclick="openWebInterface()">WEB界面</a>
                                            </td>
                                        </tr>
                                        <tr id="vnts_status">
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(4)">运行状态</th>
                                            <td><span id="status2">获取中...</span>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(17)">定时功能(<i>0为关闭</i>)</a></th>
                                            <td>
                                                每 <input type="text" oninput="this.value=this.value.replace(/[^\d]/g, '')" id="vnts_cron_time" name="vnts_cron_time" class="input_3_table" maxlength="2" value="0" placeholder="" />
                                                <select id="vnts_cron_hour_min" name="vnts_cron_hour_min" style="width:60px;margin:3px 2px 0px 2px;" class="input_option">
                                                    <option value="min">分钟</option>
                                                    <option value="hour">小时</option>
                                                </select> 
                                                    <select id="vnts_cron_type" name="vnts_cron_type" style="width:60px;margin:3px 2px 0px 2px;" class="input_option">
                                                        <option value="watch">检查</option>
                                                        <option value="start">重启</option>
                                                    </select> 一次服务
                                            </td>
                                        </tr>

                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(30)">程序运行日志</th>
                                            <td>
											    
												<a type="button" class="info_btn" style="cursor:pointer" href="javascript:void(0);" onclick="open_conf('vnts_cmd');" >状态信息</a>&nbsp;
                                                <a type="button" class="info_btn" style="cursor:pointer" href="javascript:void(0);" onclick="open_conf('vnts_fingerprint');" >获取指纹(Fingerprint)</a>&nbsp;
                                                <a type="button" class="info_btn" style="cursor:pointer" href="javascript:void(0);" onclick="open_conf('vnts_log');" >查看日志</a>
                                            
                                            </td>
                                        </tr>
										
                                        <tr style="background-color: #576d73; color: #fff;">
                                            <td colspan="3" style="font-weight: bold; padding: 6px 10px;">服务端核心参数配置</td>
                                        </tr>
                                        <tr>
                                            <th width="20%"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(50)">连接验证密码 (server_token)</a></th>
                                            <td>
                                                <input type="text" class="input_ss_table" id="vnts2_token" title="自建服务端的验证密码，客户端连接时需输入相同的密码" name="vnts2_token" placeholder="选填，限制网络客户端必须凭此密码接入" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(33)">虚拟网络分配网段 (network)</a></th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_network" title="自建服务端的虚拟分配网段，默认: 10.26.0.0/24" name="vnts2_network" placeholder="默认: 10.26.0.0/24" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>默认网络秘钥 (default_secret)</th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_default_secret" title="默认网络的连接秘钥（密码），留空则自动生成高强度秘钥。客户端需要通过此秘钥接入服务端默认网络" name="vnts2_default_secret" placeholder="留空自动生成" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(52)">IP 租约失效时长 (秒)</a></th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_lease_duration" title="IP 租约回收失效时长（秒），默认: 86400 (24小时)" name="vnts2_lease_duration" placeholder="默认: 86400 (24小时)" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(53)">本地数据持久化保存 (persistence)</a></th>
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
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(61)">局域网段网关指向 (custom_nets)</a></th>
                                            <td colspan="2">
                                                <textarea type="text" class="input_ss_table" id="vnts2_custom_nets" title="自建服务端网关指向，例如: net1=192.168.50.0/24。一行一条，以换行或逗号分隔" name="vnts2_custom_nets" placeholder="选填，格式为: 网络编号=目标局域网段 (例如 net1=192.168.1.0/24)。一行输入一条，以换行或逗号分隔" style="height: 50px; font-family:'Courier New', Courier, mono; font-size: 11px;"></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>自定义网络秘钥 (network_secrets)</th>
                                            <td colspan="2">
                                                <textarea type="text" class="input_ss_table" id="vnts2_network_secrets" title="与上面的自定义网络配套的秘钥，必须一一对应。秘钥需符合高强度要求（>=24位且包含大写、小写、数字、符号至少三种）。格式: net1=MyStrongSecret2026!@#" name="vnts2_network_secrets" placeholder="选填，格式为: 网络名=高强度秘钥 (如 net1=StrongSecret-A1!xxx) 多行用回车或逗号分隔" style="height: 50px; font-family:'Courier New', Courier, mono; font-size: 11px;"></textarea>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #576d73; color: #fff;">
                                            <td colspan="3" style="font-weight: bold; padding: 6px 10px;">绑定网口及端口设置</td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(54)">TCP 服务监听绑定 (tcp_bind)</a></th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_tcp_bind" title="自建服务端 TCP 监听绑定，默认: 0.0.0.0:29872" name="vnts2_tcp_bind" placeholder="默认: 0.0.0.0:29872" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(55)">QUIC 服务监听绑定 (quic_bind)</a></th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_quic_bind" title="自建服务端 QUIC 监听绑定，默认: 0.0.0.0:29872" name="vnts2_quic_bind" placeholder="默认: 0.0.0.0:29872" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(56)">WS/WSS 服务监听绑定 (ws_bind)</a></th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_ws_bind" title="自建服务端 WS/WSS 监听绑定，默认: 0.0.0.0:29872" name="vnts2_ws_bind" placeholder="默认: 0.0.0.0:29872" />
                                            </td>
                                        </tr>
                                        <tr style="background-color: #576d73; color: #fff;">
                                            <td colspan="3" style="font-weight: bold; padding: 6px 10px;">Web 控制后台设置</td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(37)">Web 监听绑定 (web_bind)</a></th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_web_bind" title="自建服务端 Web 监听端口，默认: 0.0.0.0:29871" name="vnts2_web_bind" placeholder="默认: 0.0.0.0:29871" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(38)">Web 登录用户名</a></th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_username" title="自建服务端 Web 登录用户名，默认: admin" name="vnts2_username" placeholder="默认: admin" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(39)">Web 登录密码</a></th>
                                            <td colspan="2">
                                                <input type="password" class="input_ss_table" id="vnts2_password" title="自建服务端 Web 登录密码，默认: admin" name="vnts2_password" placeholder="默认: admin" onBlur="switchType(this, false);" onFocus="switchType(this, true);" autocomplete="new-password" />
                                            </td>
                                        </tr>
                                        <tr style="background-color: #576d73; color: #fff;">
                                            <td colspan="3" style="font-weight: bold; padding: 6px 10px;">安全证书及对端策略 (选填)</td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(57)">TLS 公钥证书文件路径 (cert)</a></th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_cert" title="例如: /koolshare/vnt2/cert.pem" name="vnts2_cert" placeholder="例如: /koolshare/vnt2/cert.pem" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(58)">TLS 私钥密钥文件路径 (key)</a></th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_key" title="例如: /koolshare/vnt2/key.pem" name="vnts2_key" placeholder="例如: /koolshare/vnt2/key.pem" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(31)">虚拟网络 Token 接入白名单</a></th>
                                            <td colspan="2">
                                                <textarea type="text" class="input_ss_table" id="vnts2_whitelist" title="仅限指定Token接入。多个以英文逗号 '',''、''|'' 或换行分隔" name="vnts2_whitelist" placeholder="选填，仅限指定Token接入。多个以英文逗号 ','、'|' 或换行分隔" style="height: 50px; font-family:'Courier New', Courier, mono; font-size: 11px;"></textarea>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #576d73; color: #fff;">
                                            <td colspan="3" style="font-weight: bold; padding: 6px 10px;">多服务器互联设置 (选填)</td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(59)">互联监听绑定 (server_quic_bind)</a></th>
                                            <td colspan="2">
                                                <input type="text" class="input_ss_table" id="vnts2_server_quic_bind" title="多服务器级联互联监听，例如: 0.0.0.0:29873" name="vnts2_server_quic_bind" placeholder="例如: 0.0.0.0:29873" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(60)">互联服务器节点列表 (peer_servers)</a></th>
                                            <td colspan="2">
                                                <textarea type="text" class="input_ss_table" id="vnts2_peer_servers" title="多服务器级联互联地址列表，例如: 1.2.3.4:29873" name="vnts2_peer_servers" placeholder="例如: 1.2.3.4:29873。多个地址以英文逗号 ','、'|' 或换行分隔" style="height: 50px; font-family:'Courier New', Courier, mono; font-size: 11px;"></textarea>
                                            </td>
                                        </tr>
                                    </table>
                                    </div>
									<div id="conf_table">
    <table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable_table" style="box-shadow: 3px 3px 10px #000;margin-top: 0px;">
        <thead>
            <tr>
                <td colspan="2"><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(35)">上传程序</a></td>
            </tr>
        </thead>
        <tr>
            <th><a sclang class="hintstyle" href="javascript:void(0);" onclick="openssHint(35)">选择文件</a></th>
            <td>
                <input sclang type="button" id="upload_btn" class="button_gen" onclick="upload_bin();" value="上传"/>
                <input style="color:#FFCC00;*color:#000;width: 200px;" id="file" type="file" name="file"/>
                <img id="loadingicon" style="margin-left:5px;margin-right:5px;display:none;" src="/images/InternetScan.gif">
                <span sclang id="file_info" style="display:none;">上传完成</span>
            </td>
        </tr>
    </table>
    <div id="log_content" class="soft_setting_log">
											<textarea cols="63" rows="40" wrap="on" readonly="readonly" id="soft_log_area" class="soft_setting_log1" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
    </div>
</div>
<div class="apply_gen">
    <span><input class="button_gen" id="cmdBtn" onclick="save()" type="button" value="提交"/></span>
</div>
<div style="margin:30px 0 10px 5px;" class="splitLine"></div>
<div class="formbottomdesc" id="cmdDesc">
    <i>* 注意事项：</i> 请先仔细查阅官网的使用文档<br/><br/>
    1、客户端的<i>token</i>为必填项，没有服务器也可单独使用客户端，已内置公共服务器<br/>
    2、<i>点击</i>参数标题的<i>文字</i>，可<i>查看帮助</i>信息。<br/>
	3、若启动失败，请查看程序运行日志，有报错提示，或者通过SSH命令行启动测试。<br/>
	4、插件会自动下载二进制程序，也可以手动上传程序。<br/>
</div>
                                    <div id="vnts_log"  class="contentM_qis" style="box-shadow: 3px 3px 10px #000;margin-top: 70px;">
                                        <div class="user_title">VNTS 日志文件 / 标准输出&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="close_conf('vnts_log');" value="关闭"><span class="close"></span></a></div>
                                        <div id="user_tr" style="margin: 10px 10px 10px 10px;width:98%;text-align:center;">
                                            <textarea cols="50" rows="20" wrap="off" id="vnts_logtxt" style="width:97%;padding-left:10px;padding-right:10px;border:1px solid #222;font-family:'Courier New', Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;outline: none;" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                                        </div>
                                        <div style="margin-top:5px;padding-bottom:10px;width:100%;text-align:center;">
                                            <input id="edit_node1" class="button_gen" type="button" onclick="close_conf('vnts_log');" value="返回主界面">
                                            &nbsp;&nbsp;<input class="button_gen" type="button" onclick="close_conf('vnts_log');clear_vntslog();" value="清空日志">
                                        </div>
                                    </div>

									<div id="vnts_cmd"  class="contentM_qis" style="box-shadow: 3px 3px 10px #000;margin-top: 70px;">
                                        <div class="user_title">VNTS 状态参数 / 标准输出&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="close_conf('vnts_cmd');" value="关闭"><span class="close"></span></a></div>
                                        <div id="user_tr" style="margin: 10px 10px 10px 10px;width:98%;text-align:center;">
                                            <textarea cols="50" rows="20" wrap="off" id="vnts_cmdtxt" style="width:97%;padding-left:10px;padding-right:10px;border:1px solid #222;font-family:'Courier New', Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;outline: none;" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                                        </div>
                                        <div style="margin-top:5px;padding-bottom:10px;width:100%;text-align:center;">
                                            <input id="edit_node2" class="button_gen" type="button" onclick="close_conf('vnts_cmd');" value="返回主界面">
                                        </div>
                                    </div>

									<div id="vnts_fingerprint"  class="contentM_qis" style="box-shadow: 3px 3px 10px #000;margin-top: 70px;">
                                        <div class="user_title">VNTS Fingerprint 指纹&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="close_conf('vnts_fingerprint');" value="关闭"><span class="close"></span></a></div>
                                        <div id="user_tr" style="margin: 10px 10px 10px 10px;width:98%;text-align:center;">
                                            <textarea cols="50" rows="20" wrap="off" id="vnts_fingerprinttxt" style="width:97%;padding-left:10px;padding-right:10px;border:1px solid #222;font-family:'Courier New', Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;outline: none;" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                                        </div>
                                        <div style="margin-top:5px;padding-bottom:10px;width:100%;text-align:center;">
                                            <input id="edit_node2" class="button_gen" type="button" onclick="close_conf('vnts_fingerprint');" value="返回主界面">
                                        </div>
                                    </div>

                                    <div id="vnt_log"  class="contentM_qis" style="box-shadow: 3px 3px 10px #000;margin-top: 70px;">
                                        <div class="user_title">VNT 日志文件 / 标准输出&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="close_conf('vnt_log');" value="关闭"><span class="close"></span></a></div>
                                        <div id="user_tr" style="margin: 10px 10px 10px 10px;width:98%;text-align:center;">
                                            <textarea cols="50" rows="20" wrap="off" id="vnt_logtxt" style="width:97%;padding-left:10px;padding-right:10px;border:1px solid #222;font-family:'Courier New', Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;outline: none;" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                                        </div>
                                        <div style="margin-top:5px;padding-bottom:10px;width:100%;text-align:center;">
                                            <input id="edit_node3" class="button_gen" type="button" onclick="close_conf('vnt_log');" value="返回主界面">
                                            &nbsp;&nbsp;<input class="button_gen" type="button" onclick="close_conf('vnt_log');clear_vntlog();" value="清空日志">
                                        </div>
										</div>

										<div id="vnt_info"  class="contentM_qis" style="box-shadow: 3px 3px 10px #000;margin-top: 70px;">
                                        <div class="user_title">VNT 本机设备信息 / 标准输出&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="close_conf('vnt_info');" value="关闭"><span class="close"></span></a></div>
                                        <div id="user_tr" style="margin: 10px 10px 10px 10px;width:98%;text-align:center;">
                                            <textarea cols="50" rows="20" wrap="off" id="vnt_infotxt" style="width:97%;padding-left:10px;padding-right:10px;border:1px solid #222;font-family:'Courier New', Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;outline: none;" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                                        </div>
                                        <div style="margin-top:5px;padding-bottom:10px;width:100%;text-align:center;">
                                            <input id="edit_node4" class="button_gen" type="button" onclick="close_conf('vnt_info');" value="返回主界面">
                                        </div></div>

										<div id="vnt_all"  class="contentM_qis" style="box-shadow: 3px 3px 10px #000;margin-top: 70px;">
                                        <div class="user_title">VNT 所有设备信息/ 标准输出&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="close_conf('vnt_all');" value="关闭"><span class="close"></span></a></div>
                                        <div id="user_tr" style="margin: 10px 10px 10px 10px;width:98%;text-align:center;">
                                            <textarea cols="50" rows="20" wrap="off" id="vnt_alltxt" style="width:97%;padding-left:10px;padding-right:10px;border:1px solid #222;font-family:'Courier New', Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;outline: none;" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                                        </div>
                                        <div style="margin-top:5px;padding-bottom:10px;width:100%;text-align:center;">
                                            <input id="edit_node5" class="button_gen" type="button" onclick="close_conf('vnt_all');" value="返回主界面">
                                        </div></div>

										<div id="vnt_list"  class="contentM_qis" style="box-shadow: 3px 3px 10px #000;margin-top: 70px;">
                                        <div class="user_title">VNT 所有设备列表 / 标准输出&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="close_conf('vnt_list');" value="关闭"><span class="close"></span></a></div>
                                        <div id="user_tr" style="margin: 10px 10px 10px 10px;width:98%;text-align:center;">
                                            <textarea cols="50" rows="20" wrap="off" id="vnt_listtxt" style="width:97%;padding-left:10px;padding-right:10px;border:1px solid #222;font-family:'Courier New', Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;outline: none;" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                                        </div>
                                        <div style="margin-top:5px;padding-bottom:10px;width:100%;text-align:center;">
                                            <input id="edit_node6" class="button_gen" type="button" onclick="close_conf('vnt_list');" value="返回主界面">
                                        </div></div>

										<div id="vnt_route"  class="contentM_qis" style="box-shadow: 3px 3px 10px #000;margin-top: 70px;">
                                        <div class="user_title">VNT 路由转发信息 / 标准输出&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="close_conf('vnt_route');" value="关闭"><span class="close"></span></a></div>
                                        <div id="user_tr" style="margin: 10px 10px 10px 10px;width:98%;text-align:center;">
                                            <textarea cols="50" rows="20" wrap="off" id="vnt_routetxt" style="width:97%;padding-left:10px;padding-right:10px;border:1px solid #222;font-family:'Courier New', Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;outline: none;" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                                        </div>
                                        <div style="margin-top:5px;padding-bottom:10px;width:100%;text-align:center;">
                                            <input id="edit_node7" class="button_gen" type="button" onclick="close_conf('vnt_route');" value="返回主界面">
                                        </div></div>

										<div id="vnt_cmd"  class="contentM_qis" style="box-shadow: 3px 3px 10px #000;margin-top: 70px;">
                                        <div class="user_title">VNT 状态参数 / 标准输出&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="close_conf('vnt_cmd');" value="关闭"><span class="close"></span></a></div>
                                        <div id="user_tr" style="margin: 10px 10px 10px 10px;width:98%;text-align:center;">
                                            <textarea cols="50" rows="20" wrap="off" id="vnt_cmdtxt" style="width:97%;padding-left:10px;padding-right:10px;border:1px solid #222;font-family:'Courier New', Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;outline: none;" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                                        </div>
                                        <div style="margin-top:5px;padding-bottom:10px;width:100%;text-align:center;">
                                            <input id="edit_node8" class="button_gen" type="button" onclick="close_conf('vnt_cmd');" value="返回主界面">
                                        </div></div>


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
</form>
<div id="footer"></div>
</body>
</html>




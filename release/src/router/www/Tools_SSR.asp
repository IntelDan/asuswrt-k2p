﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html xmlns:v>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">
<title><#Web_Title#> - <#SSR#></title>
<link rel="shortcut icon" href="images/favicon.png">
<link rel="icon" href="images/favicon.png">
<link rel="stylesheet" type="text/css" href="ParentalControl.css">
<link rel="stylesheet" type="text/css" href="index_style.css">
<link rel="stylesheet" type="text/css" href="form_style.css">
<link rel="stylesheet" type="text/css" href="usp_style.css">
<link rel="stylesheet" type="text/css" href="/calendar/fullcalendar.css">
<link rel="stylesheet" type="text/css" href="/device-map/device-map.css">
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/client_function.js"></script>
<script type="text/javascript" src="/validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/calendar/jquery-ui.js"></script>
<script type="text/javascript" src="/switcherplugin/jquery.iphone-switch.js"></script>
<style>
#selectable .ui-selecting { background: #FECA40; }
#selectable .ui-selected { background: #F39814; color: white; }
#selectable .ui-unselected { background: gray; color: green; }
#selectable .ui-unselecting { background: green; color: black; }
#selectable { border-spacing:0px; margin-left:0px;margin-top:0px; padding: 0px; width:100%;}
#selectable td { height: 22px; }
.parental_th{
color:white;
background:#2F3A3E;
cursor: pointer;
width:160px;
height:22px;
border-bottom:solid 1px black;
border-right:solid 1px black;
}
.parental_th:hover{
background:rgb(94, 116, 124);
cursor: pointer;
}
.checked{
background-color:#9CB2BA;
width:82px;
border-bottom:solid 1px black;
border-right:solid 1px black;
}
.disabled{
width:82px;
border-bottom:solid 1px black;
border-right:solid 1px black;
}
#switch_menu{
text-align:right
}
#switch_menu span{
/*border:1px solid #222;*/
border-radius:4px;
font-size:16px;
padding:3px;
}
/*#switch_menu span:hover{
box-shadow:0px 0px 5px 3px white;
background-color:#97CBFF;
}*/
.click:hover{
box-shadow:0px 0px 5px 3px white;
background-color:#97CBFF;
}
.clicked{
background-color:#2894FF;
box-shadow:0px 0px 5px 3px white;
}
.click{
background:#8E8E8E;
}
.contentM_qis{
position:absolute;
-webkit-border-radius: 5px;
-moz-border-radius: 5px;
border-radius: 5px;
z-index:200;
background-color:#2B373B;
display:none;
margin-left: 32%;
top: 250px;
}
</style>
<script>
var ssr_server_enable = '<% nvram_get("ssr_server_enable"); %>'.replace(/&#62/g, ">");
﻿var ssr_server_alias = decodeURIComponent('<% nvram_get("ssr_server_alias"); %>');
var ssr_server_ip = '<% nvram_get("ssr_server_ip"); %>'.replace(/&#62/g, ">");
var ssr_server_port = '<% nvram_get("ssr_server_port"); %>'.replace(/&#62/g, ">");
var ssr_server_timeout = '<% nvram_get("ssr_server_timeout"); %>'.replace(/&#62/g, ">");
var ssr_server_passwd = '<% nvram_get("ssr_server_passwd"); %>'.replace(/&#62/g, ">");
var ssr_server_encrypt = '<% nvram_get("ssr_server_encrypt"); %>'.replace(/&#62/g, ">");
var ssr_server_protocol = '<% nvram_get("ssr_server_protocol"); %>'.replace(/&#62/g, ">");
var ssr_server_obfs = '<% nvram_get("ssr_server_obfs"); %>'.replace(/&#62/g, ">");
var ssr_server_obfspara = '<% nvram_get("ssr_server_obfspara"); %>'.replace(/&#62/g, ">");
var ssr_server_enable_row = ssr_server_enable.split('>');
var ssr_server_alias_row = ssr_server_alias.split('>');
var ssr_server_ip_row = ssr_server_ip.split('>');
var ssr_server_port_row = ssr_server_port.split('>');
var ssr_server_timeout_row = ssr_server_timeout.split('>');
var ssr_server_passwd_row = ssr_server_passwd.split('>');
var ssr_server_encrypt_row = ssr_server_encrypt.split('>');
var ssr_server_protocol_row = ssr_server_protocol.split('>');
var ssr_server_obfs_row = ssr_server_obfs.split('>');
var ssr_server_obfspara_row = ssr_server_obfspara.split('>');
function gen_server_list(){
var code = "";
if(ssr_server_alias=="")
{
code +='<option value="0">无服务器配置</option>';
document.getElementById("ssr_index_id").innerHTML = code;
return;
}
sindex='<% nvram_get("ssr_index"); %>';
for(var idx = 0; idx < ssr_server_alias_row.length; idx += 1) {
if(idx+1==sindex)
code +='<option value="'+(idx+1)+'" selected="selected">'+ssr_server_alias_row[idx]+'</option>';
else
code +='<option value="'+(idx+1)+'" >'+ssr_server_alias_row[idx]+'</option>';
}
document.getElementById("ssr_index_id").innerHTML = code;
}
function gen_para_list(sindex){
var encrypt_methods = new Array(
"table",
"rc4",
"rc4-md5",
"rc4-md5-6",
"aes-128-cfb",
"aes-192-cfb",
"aes-256-cfb",
"aes-128-ctr",
"aes-192-ctr",
"aes-256-ctr",
"bf-cfb",
"camellia-128-cfb",
"camellia-192-cfb",
"camellia-256-cfb",
"cast5-cfb",
"des-cfb",
"idea-cfb",
"rc2-cfb",
"seed-cfb",
"salsa20",
"chacha20",
"chacha20-ietf"
);
var protocol = new Array(
"origin",
"verify_simple",
"verify_sha1",
"auth_sha1",
"auth_sha1_v2",
"auth_sha1_v4",
"auth_aes128_sha1",
"auth_aes128_md5"
)
var obfs = new Array(
"plain",
"http_simple",
"http_post",
"tls_simple",
"tls1.2_ticket_auth"
)
var code = "";
var mencrypt_methods=ssr_server_encrypt_row[sindex];
for(var idx = 0; idx < encrypt_methods.length; idx += 1) {
if(mencrypt_methods==encrypt_methods[idx])
code +='<option value="'+encrypt_methods[idx]+'" selected="selected">'+encrypt_methods[idx]+'</option>';
else
code +='<option value="'+encrypt_methods[idx]+'" >'+encrypt_methods[idx]+'</option>';
}
document.getElementById("Server_encrypt_id").innerHTML = code;
code = "";
var mprotocol=ssr_server_protocol_row[sindex];
for(var idx = 0; idx < protocol.length; idx += 1) {
if(mprotocol==protocol[idx])
code +='<option value="'+protocol[idx]+'" selected="selected">'+protocol[idx]+'</option>';
else
code +='<option value="'+protocol[idx]+'" >'+protocol[idx]+'</option>';
}
document.getElementById("Server_protocol_id").innerHTML = code;
code = "";
var mobfs=ssr_server_obfs_row[sindex];
for(var idx = 0; idx < obfs.length; idx += 1) {
if(mobfs==obfs[idx])
code +='<option value="'+obfs[idx]+'" selected="selected">'+obfs[idx]+'</option>';
else
code +='<option value="'+obfs[idx]+'" >'+obfs[idx]+'</option>';
}
document.getElementById("Server_obfs_id").innerHTML = code;
}
function cancel_add(){
$("#user_config").fadeOut(300);
}
function ok_add(){
$("#user_config").fadeOut(300);
document.form.save_name.value = document.getElementById("file_path").innerHTML;
if(document.getElementById("file_content1").style.display=="none")
document.form.save_content.value = document.getElementById("file_content2").value.replace(/\r\n/g,",yushi,");
else
document.form.save_content.value = document.getElementById("file_content1").value.replace(/\r\n/g,",yushi,");
document.form.save_content.value = document.form.save_content.value.replace(/\n/g,",yushi,");
document.form.action= "/start_save.htm";
showLoading();
document.form.submit();
}
function Add_userfile(idx){
if(idx==0)
{
document.getElementById("file_title").innerHTML = "GFW列表";
document.getElementById("file_name").innerHTML = '可以将指定的网站加入GFW列表，GFW列表模式生效<br>比如增加xxx.com到GFW，则输入".xxx.com"，每行一个';
document.getElementById("file_path").innerHTML = "/jffs/configs/ssr_gfw.txt";
document.getElementById("file_content1").style.display= "";
document.getElementById("file_content2").style.display= "none";
}
else
{
document.getElementById("file_title").innerHTML = "忽略IP列表";
document.getElementById("file_name").innerHTML = '不经过代理的目的IP列表，国外代理模式有效<br>每行一个IP地址或者IP网段';
document.getElementById("file_path").innerHTML = "/jffs/configs/ssr_user.txt";
document.getElementById("file_content1").style.display= "none";
document.getElementById("file_content2").style.display= "";
}
$("#user_config").fadeIn(300);
}
function initial(){
show_menu();
show_footer();
gen_server_list();
gen_mainTable();
}
/*----------create main table-----------------*/
function gen_mainTable(){
var code = "";
code +='<table width="100%" border="1" cellspacing="0" cellpadding="4" align="center" class="FormTable_table" id="mainTable_table">';
code +='<thead><tr><td colspan="4">服务器列表&nbsp;(最多限制&nbsp;16)</td></tr></thead>';
code +='<tr><th width="10%" height="30px" title="<#select_all#>"><input id="selAll" type=\"checkbox\" onclick=\"selectAll(this, 0);\" value=\"\"/></th>';
code +='<th width="50%">服务器别名</th>';/*untranslated*/
code +='<th width="20%">参数配置</th>';
code +='<th width="20%">增加/删除</th></tr>';
code +='<tr><td style="border-bottom:2px solid #000;" title="<#CTL_Enabled#>/<#CTL_close#>"><input type=\"checkbox\" id="newrule_Enable" checked></td>';
code +='<td style="border-bottom:2px solid #000;"><input type="text" maxlength="17" style="margin-left:0px;width:255px;" class="input_20_table" name="Server_alias" autocorrect="off" autocapitalize="off" placeholder="请输入一个服务器别名"></td>';
code +='<td style="border-bottom:2px solid #000;">--</td>';
code +='<td style="border-bottom:2px solid #000;"><input class="url_btn" type="button" onClick="addRow_main(16)" value=""></td></tr>';
if(ssr_server_alias == "")
code +='<tr><td style="color:#FFCC00;" colspan="4">目前没有数据</td>';
else{
var dispName;
for(var i=0; i<ssr_server_alias_row.length; i++){
dispName = ssr_server_alias_row[i];
code +='<tr id="row'+i+'">';
code +='<td title="'+ ssr_server_enable_row[i] +'"><input type=\"checkbox\" onclick=\"genEnableArray_main('+i+',this);\" '+genChecked(ssr_server_enable_row[i])+'/></td>';
code +='<td title="'+dispName+'">';
code += '<table width="100%"><tr><td style="width:15%;border:0;float:right;padding-right:30px;">';
code += '</td><td id="client_info_'+i+'" style="width:85%;text-align:left;border:0;">';
code += '<div>' + dispName + '</div>';
code += '<div>IP:' + ssr_server_ip_row[i] +'，端口:'+ ssr_server_port_row[i] + '</div>';
code += '</td></tr></table>';
code +='</td>';
code +='<td><input class=\"service_btn\" type=\"button\" onclick=\"modify_ssr('+i+');" value=\"\"/></td>';
code +='<td><input class=\"remove_btn\" type=\"button\" onclick=\"deleteRow_main(this, \''+i+'\');\" value=\"\"/></td>';
}
}
code +='</tr></table>';
document.getElementById("mainTable").style.display = "";
document.getElementById("mainTable").innerHTML = code;
$("#mainTable").fadeIn();
document.getElementById("ctrlBtn").innerHTML = '<input class="button_gen" type="button" onClick="applyRule(1);" value="<#CTL_apply#>">';
}
function selectAll(obj, tab){
var tag_name= document.getElementsByTagName('input');
var tag = 0;
for(var i=0;i<tag_name.length;i++){
if(tag_name[i].type == "checkbox"){
if(tab == 1){
tag++;
if(tag > 7)
tag_name[i].checked = obj.checked;
}
else
tag_name[i].checked = obj.checked;
}
}
if(obj.checked)
ssr_server_enable = ssr_server_enable.replace(/0/g, "1");
else
ssr_server_enable = ssr_server_enable.replace(/1/g, "0");
}
function applyRule(_on){
document.form.ssr_server_enable.value = ssr_server_enable;
document.form.ssr_server_alias.value = encodeURIComponent(ssr_server_alias);
document.form.ssr_server_ip.value = ssr_server_ip;
document.form.ssr_server_port.value = ssr_server_port;
document.form.ssr_server_timeout.value = ssr_server_timeout;
document.form.ssr_server_passwd.value = ssr_server_passwd;
document.form.ssr_server_encrypt.value = ssr_server_encrypt;
document.form.ssr_server_protocol.value = ssr_server_protocol;
document.form.ssr_server_obfs.value = ssr_server_obfs;
document.form.ssr_server_obfspara.value = ssr_server_obfspara;
showLoading();
document.form.submit();
}
function genChecked(_flag){
if(_flag == 1)
return "checked";
else
return "";
}
function modify_ssr(s_index){
var code = "";
code +='<div style="margin-bottom:10px;color: #003399;font-family: Verdana;" align="left">';
code +='<table width="100%" border="1" cellspacing="0" cellpadding="4" align="center" class="FormTable">';
code +='<thead><tr><td colspan="6" id="LWFilterList">服务器参数配置</td></tr></thead>';
code +='<tr><th style="height:20px;" align="right">服务器别名</th>';
code +='<td align="left" style="color:#FFF">'+ ssr_server_alias_row[s_index] + '</td></tr>';
code +='<tr><th style="height:20px;" align="right">服务器IP</th>';
code +='<td align="left" style="color:#FFF"><input name=Server_ip onKeyPress="return validator.isIPAddr(this, event);" autocorrect="off" autocapitalize="off" value='+ ssr_server_ip_row[s_index] + '></td></tr>';
code +='<tr><th style="height:20px;" align="right">服务器端口</th>';
code +='<td align="left" style="color:#FFF"><input name=Server_port value='+ ssr_server_port_row[s_index] + '></td></tr>';
code +='<tr><th style="height:20px;" align="right">超时时间</th>';
code +='<td align="left" style="color:#FFF"><input name=Server_timeout value='+ ssr_server_timeout_row[s_index] + '></td></tr>';
code +='<tr><th style="height:20px;" align="right">密码</th>';
code +='<td align="left" style="color:#FFF"><input name=Server_passwd value='+ ssr_server_passwd_row[s_index] + '></td></tr>';
code +='<tr><th style="height:20px;" align="right">加密方式</th>';
code +='<td align="left" style="color:#FFF"><select id="Server_encrypt_id" name="Server_encrypt" ></select></td></tr>';
code +='<tr><th style="height:20px;" align="right">传输协议</th>';
code +='<td align="left" style="color:#FFF"><select id="Server_protocol_id" name="Server_protocol"></select></td></tr>';
code +='<tr><th style="height:20px;" align="right">混淆插件</th>';
code +='<td align="left" style="color:#FFF"><select id="Server_obfs_id" name="Server_obfs"></select></td></tr>';
code +='<tr><th style="height:20px;" align="right">混淆参数</th>';
code +='<td align="left" style="color:#FFF"><input name=Server_obfspara value='+ ssr_server_obfspara_row[s_index] + '></td></tr>';
code +='<tr><th style="height:20px;" align="right">启用Kcptun</th>';
code +='<td align="left" style="color:#FFF"><select id="kcptun_enable" name="kcptun_enable"> <option value="0" <% nvram_match( "kcptun_enable", "0","selected"); %>>禁用</option><option value="1" <% nvram_match( "kcptun_enable", "1","selected"); %>>启用</option></select></td></tr>';
code +='</table></div>';
document.getElementById("mainTable").innerHTML = code;
document.getElementById("ctrlBtn").innerHTML = '<input class="button_gen" type="button" onClick="cancel_ssr('+s_index+');" value="<#CTL_Cancel#>">';
document.getElementById("ctrlBtn").innerHTML += '<input class="button_gen" type="button" onClick="saveto_ssr('+s_index+');" value="<#CTL_ok#>">';
document.getElementById("mainTable").style.display = "";
gen_para_list(s_index);
$("#mainTable").fadeIn();
}
function addRow_main(upper){
var invalid_char = "";
var rule_num = document.getElementById('mainTable_table').rows.length - 3; // remove tbody
if(rule_num >= upper){
alert("服务器数目超过最大限制： " + upper + " ！");
return false;
}
if(document.form.Server_alias.value == ""){
alert("请输入服务器别名，可以使用中文");
document.form.Server_alias.focus();
return false;
}
if(ssr_server_alias.search(document.form.Server_alias.value) > -1){
alert("别名重复，请修改");
document.form.Server_alias.focus();
return false;
}
if(ssr_server_alias != "" ){
ssr_server_enable += ">";
ssr_server_alias += ">";
ssr_server_ip += ">";
ssr_server_port += ">";
ssr_server_timeout += ">";
ssr_server_passwd += ">";
ssr_server_encrypt += ">";
ssr_server_protocol += ">";
ssr_server_obfs += ">";
ssr_server_obfspara += ">";
}
else
{
ssr_server_enable = "";
ssr_server_alias = "";
ssr_server_ip = "";
ssr_server_port = "";
ssr_server_timeout = "";
ssr_server_passwd = "";
ssr_server_encrypt = "";
ssr_server_protocol = "";
ssr_server_obfs = "";
ssr_server_obfspara = "";
}
if(document.getElementById("newrule_Enable").checked)
ssr_server_enable += "1";
else
ssr_server_enable += "0";
ssr_server_alias += document.form.Server_alias.value;
ssr_server_ip += "0.0.0.0";
ssr_server_port += "8388";
ssr_server_timeout += "60";
ssr_server_passwd += "hellossr";
ssr_server_encrypt += "rc4-md5";
ssr_server_protocol += "origin";
ssr_server_obfs += "plain";
ssr_server_obfspara += "";
ssr_server_enable_row = ssr_server_enable.split('>');
ssr_server_alias_row = ssr_server_alias.split('>');
ssr_server_ip_row = ssr_server_ip.split('>');
ssr_server_port_row = ssr_server_port.split('>');
ssr_server_timeout_row = ssr_server_timeout.split('>');
ssr_server_passwd_row = ssr_server_passwd.split('>');
ssr_server_encrypt_row = ssr_server_encrypt.split('>');
ssr_server_protocol_row = ssr_server_protocol.split('>');
ssr_server_obfs_row = ssr_server_obfs.split('>');
ssr_server_obfspara_row = ssr_server_obfspara.split('>');
document.form.Server_alias.value = "";
gen_server_list();
modify_ssr(ssr_server_alias_row.length-1);
}
function deleteRow_main(r, del_index){
var j=r.parentNode.parentNode.rowIndex;
document.getElementById(r.parentNode.parentNode.parentNode.parentNode.id).deleteRow(j);
var ssr_server_enable_tmp = "";
var ssr_server_alias_tmp = "";
var ssr_server_ip_tmp = "";
var ssr_server_port_tmp = "";
var ssr_server_timeout_tmp = "";
var ssr_server_passwd_tmp = "";
var ssr_server_encrypt_tmp = "";
var ssr_server_protocol_tmp = "";
var ssr_server_obfs_tmp = "";
var ssr_server_obfspara_tmp = "";
var ssr_server_enable_array = ssr_server_enable.split(">");
var ssr_server_alias_array = ssr_server_alias.split(">");
var ssr_server_ip_array = ssr_server_ip.split(">");
var ssr_server_port_array = ssr_server_port.split(">");
var ssr_server_timeout_array = ssr_server_timeout.split(">");
var ssr_server_passwd_array = ssr_server_passwd.split(">");
var ssr_server_encrypt_array = ssr_server_encrypt.split(">");
var ssr_server_protocol_array = ssr_server_protocol.split(">");
var ssr_server_obfs_array = ssr_server_obfs.split(">");
var ssr_server_obfspara_array = ssr_server_obfspara.split(">");
for(var idx = 0; idx < ssr_server_alias_array.length; idx += 1) {
if(idx != del_index) {
if(ssr_server_alias_tmp != "") {
ssr_server_enable_tmp += ">";
ssr_server_alias_tmp += ">";
ssr_server_ip_tmp += ">";
ssr_server_port_tmp += ">";
ssr_server_timeout_tmp += ">";
ssr_server_passwd_tmp += ">";
ssr_server_encrypt_tmp += ">";
ssr_server_protocol_tmp += ">";
ssr_server_obfs_tmp += ">";
ssr_server_obfspara_tmp += ">";
}
ssr_server_enable_tmp += ssr_server_enable_array[idx];
ssr_server_alias_tmp += ssr_server_alias_array[idx];
ssr_server_ip_tmp += ssr_server_ip_array[idx];
ssr_server_port_tmp += ssr_server_port_array[idx];
ssr_server_timeout_tmp += ssr_server_timeout_array[idx];
ssr_server_passwd_tmp += ssr_server_passwd_array[idx];
ssr_server_encrypt_tmp += ssr_server_encrypt_array[idx];
ssr_server_protocol_tmp += ssr_server_protocol_array[idx];
ssr_server_obfs_tmp += ssr_server_obfs_array[idx];
ssr_server_obfspara_tmp += ssr_server_obfspara_array[idx];
}
}
ssr_server_enable = ssr_server_enable_tmp;
ssr_server_alias = ssr_server_alias_tmp;
ssr_server_ip = ssr_server_ip_tmp;
ssr_server_port = ssr_server_port_tmp;
ssr_server_timeout = ssr_server_timeout_tmp;
ssr_server_passwd = ssr_server_passwd_tmp;
ssr_server_encrypt = ssr_server_encrypt_tmp;
ssr_server_protocol = ssr_server_protocol_tmp;
ssr_server_obfs = ssr_server_obfs_tmp;
ssr_server_obfspara = ssr_server_obfspara_tmp;
ssr_server_enable_row = ssr_server_enable.split('>');
ssr_server_alias_row = ssr_server_alias.split('>');
ssr_server_ip_row = ssr_server_ip.split('>');
ssr_server_port_row = ssr_server_port.split('>');
ssr_server_timeout_row = ssr_server_timeout.split('>');
ssr_server_passwd_row = ssr_server_passwd.split('>');
ssr_server_encrypt_row = ssr_server_encrypt.split('>');
ssr_server_protocol_row = ssr_server_protocol.split('>');
ssr_server_obfs_row = ssr_server_obfs.split('>');
ssr_server_obfspara_row = ssr_server_obfspara.split('>');
gen_server_list();
gen_mainTable();
}
function saveto_ssr(sindex){
ssr_server_ip_row[sindex] = document.form.Server_ip.value ;
ssr_server_port_row[sindex] = document.form.Server_port.value ;
ssr_server_timeout_row[sindex] = document.form.Server_timeout.value ;
ssr_server_passwd_row[sindex] = document.form.Server_passwd.value ;
ssr_server_encrypt_row[sindex] = document.form.Server_encrypt.value ;
ssr_server_protocol_row[sindex] = document.form.Server_protocol.value ;
ssr_server_obfs_row[sindex] = document.form.Server_obfs.value ;
ssr_server_obfspara_row[sindex] = document.form.Server_obfspara.value ;
for(var idx = 0; idx < ssr_server_alias_row.length; idx += 1) {
if(idx==0)
{
ssr_server_ip=ssr_server_ip_row[0];
ssr_server_port=ssr_server_port_row[0];
ssr_server_timeout=ssr_server_timeout_row[0];
ssr_server_passwd=ssr_server_passwd_row[0];
ssr_server_encrypt=ssr_server_encrypt_row[0];
ssr_server_protocol=ssr_server_protocol_row[0];
ssr_server_obfs=ssr_server_obfs_row[0];
ssr_server_obfspara=ssr_server_obfspara_row[0];
} else {
ssr_server_ip +=">"+ssr_server_ip_row[idx];
ssr_server_port+=">"+ssr_server_port_row[idx];
ssr_server_timeout+=">"+ssr_server_timeout_row[idx];
ssr_server_passwd+=">"+ssr_server_passwd_row[idx];
ssr_server_encrypt+=">"+ssr_server_encrypt_row[idx];
ssr_server_protocol+=">"+ssr_server_protocol_row[idx];
ssr_server_obfs+=">"+ssr_server_obfs_row[idx];
ssr_server_obfspara+=">"+ssr_server_obfspara_row[idx];
}
}
gen_mainTable();
}
function cancel_ssr(sindex){
gen_mainTable();
}
function genEnableArray_main(j, obj){
document.getElementById("selAll").checked = false;
ssr_server_enable_row = ssr_server_enable.split('>');
if(obj.checked){
obj.parentNode.title = "1";
ssr_server_enable_row[j] = "1";
}
else{
obj.parentNode.title = "0";
ssr_server_enable_row[j] = "0";
}
ssr_server_enable = "";
for(i=0; i<ssr_server_enable_row.length; i++){
ssr_server_enable += ssr_server_enable_row[i];
if(i<ssr_server_enable_row.length-1)
ssr_server_enable += ">";
}
}
</script></head>
<body onload="initial();" onunload="unload_body();" onselectstart="return false;">
<div id="TopBanner"></div>
<div id="Loading" class="popup_bg"></div>
<iframe name="hidden_frame" id="hidden_frame" width="0" height="0" frameborder="0"></iframe>
<form method="post" name="form" action="/start_apply.htm" target="hidden_frame">
<input type="hidden" name="productid" value="<% nvram_get("productid"); %>">
<input type="hidden" name="current_page" value="Tools_SSR.asp">
<input type="hidden" name="next_page" value="">
<input type="hidden" name="modified" value="0">
<input type="hidden" name="action_wait" value="2">
<input type="hidden" name="action_mode" value="apply">
<input type="hidden" name="action_script" value="myscript_ssr.sh">
<input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>" disabled>
<input type="hidden" name="firmver" value="<% nvram_get("firmver"); %>">
<input type="hidden" name="ssr_enable" value="<% nvram_get("ssr_enable"); %>">
<input type="hidden" name="ssr_monitor_enable" value="<% nvram_get("ssr_monitor_enable"); %>">
<input type="hidden" name="ssr_server_enable" value="<% nvram_get("ssr_server_enable"); %>">
<input type="hidden" name="ssr_server_alias" value="<% nvram_get("ssr_server_alias"); %>">
<input type="hidden" name="ssr_server_ip" value="<% nvram_get("ssr_server_ip"); %>">
<input type="hidden" name="ssr_server_port" value="<% nvram_get("ssr_server_port"); %>">
<input type="hidden" name="ssr_server_timeout" value="<% nvram_get("ssr_server_timeout"); %>">
<input type="hidden" name="ssr_server_passwd" value="<% nvram_get("ssr_server_passwd"); %>">
<input type="hidden" name="ssr_server_encrypt" value="<% nvram_get("ssr_server_encrypt"); %>">
<input type="hidden" name="ssr_server_protocol" value="<% nvram_get("ssr_server_protocol"); %>">
<input type="hidden" name="ssr_server_obfs" value="<% nvram_get("ssr_server_obfs"); %>">
<input type="hidden" name="ssr_server_obfspara" value="<% nvram_get("ssr_server_obfspara"); %>">
<input type="hidden" name="save_name" value="">
<input type="hidden" name="save_content" value="">
<div id="user_config" class="contentM_qis" style="box-shadow: 1px 5px 10px #0FF;">
<table class="QISform_wireless" border=0 align="center" cellpadding="5" cellspacing="0">
<tr>
<td colspan="2" style="background:linear-gradient(to bottom, #92A0A5 0%, #66757C 100%)" id="file_title" >
GFW列表
</td>
</tr>
<tr>
<th>自定义内容：</th>
<td id="file_name">
GFW列表
</td>
</tr>
<tr>
<th>文件路径：</th>
<td id="file_path">/jffs/configs/gfw.txt</td>
</tr>
<tr>
<td colspan="2">
<textarea cols="90" rows="22" wrap="off" id="file_content1" style="width:99%;font-family:Courier New, Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;">
<% nvram_dump("/jffs/configs/ssr_gfw.txt",""); %>
</textarea>
<textarea cols="90" rows="22" wrap="off" id="file_content2" style="width:99%;font-family:Courier New, Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;display:none;">
<% nvram_dump("/jffs/configs/ssr_user.txt",""); %>
</textarea>
</td>
</tr>
</table>
<div style="margin-top:5px;padding-bottom:10px;width:100%;text-align:center;">
<input class="button_gen" type="button" onclick="cancel_add();" id="cancelBtn" value="<#CTL_Cancel#>">
<input class="button_gen" type="button" onclick="ok_add();" value="<#CTL_ok#>">
</div>
</div>
<table class="content" align="center" cellpadding="0" cellspacing="0" >
<tr>
<td width="17">&nbsp;</td>
<td valign="top" width="202">
<div id="mainMenu"></div>
<div id="subMenu"></div>
</td>
<td valign="top">
<div id="tabMenu" class="submenuBlock"></div>
<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0" >
<tr>
<td valign="top" >
<table width="730px" border="0" cellpadding="4" cellspacing="0" class="FormTitle" id="FormTitle">
<tbody>
<tr>
<td bgcolor="#4D595D" valign="top">
<div>&nbsp;</div>
<div style="margin-top:-5px;">
<table width="730px">
<tr>
<td align="left" >
<div id="content_title" class="formfonttitle" style="width:400px">ShadowsocksR服务</div>
</td>
</tr>
</table>
<div style="margin:0px 0px 10px 5px;"><img src="/images/New_ui/export/line_export.png"></div>
</div>
<div id="PC_desc">
<table width="700px" style="margin-left:25px;">
<tr>
<td>
<div id="guest_image" style="background: url(images/New_ui/ssr.png);width: 100px;height: 87px;"></div>
</td>
<td>&nbsp;&nbsp;</td>
<td style="font-style: italic;font-size: 14px;">
<span id="desc_title">SSR使用步骤：</span>
<ol>
<li>首先自行获取SSR或SS服务器参数</li>
<li>为服务器取个别名，比如“美国服务器”，添加服务器到服务器列表并输入参数</li>
<li>最后选择需要连接的服务器，启用SSR。服务器勾选表示参与自动切换。</li>
</ol>
<span id="desc_note" style="color:#FC0;">注意：</span>
<ol style="color:#FC0;margin:-5px 0px 3px -18px;*margin-left:18px;">
<li>如果是SS服务器，传输协议、混淆插件分别设置为origin、plain</li>
<li>所有别名及参数中不允许有">"字符</li>
</ol>
</td>
</tr>
</table>
</div>
<div id="edit_time_anchor"></div>
<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable">
<tr>
<th id="PC_enable">启用SSR</th>
<td>
<div align="center" class="left" style="width:94px; float:left; cursor:pointer;" id="radio_SSR_enable"></div>
<div class="iphone_switch_container" style="height:32px; width:74px; position: relative; overflow: hidden">
<script type="text/javascript">
$('#radio_SSR_enable').iphoneSwitch('<% nvram_get("ssr_enable"); %>',
function(){
document.form.ssr_enable.value = 1;
},
function(){
document.form.ssr_enable.value = 0;
}
);
</script>
</div>
</td>
</tr>
</table>
<table id="list_table" width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
<tr>
<td valign="top" align="center">
<div id="VSList_Block"></div>
<div >
<table width="100%" border="1" cellspacing="0" cellpadding="4" class="FormTable">
<tr>
<th width="20%">进程监控</th>
<td align="left">
<div align="center" class="left" style="width:94px; float:left; cursor:pointer;" id="radio_ssr_monitor_enable"></div>
<div class="iphone_switch_container" style="height:32px; width:74px; position: relative; overflow: hidden">
<script type="text/javascript">
$('#radio_ssr_monitor_enable').iphoneSwitch('<% nvram_get("ssr_monitor_enable"); %>',
function(){
document.form.ssr_monitor_enable.value = 1;
},
function(){
document.form.ssr_monitor_enable.value = 0;
}
);
</script>
</div>
</td>
</tr>
<tr>
<th>运行模式</th>
<td>
<select name="ssr_mode" class="input_option input_15_table">
<option value="0" <% nvram_match( "ssr_mode", "0","selected"); %>>国外代理模式</option>
<option value="1" <% nvram_match( "ssr_mode", "1","selected"); %>>GFW列表模式</option>
<option value="2" <% nvram_match( "ssr_mode", "2","selected"); %>>全局代理模式</option>
</select>
</td>
</tr>
<tr>
<th>DNS解析</th>
<td>
<select name="ssr_dnsmode" class="input_option input_15_table">
<option value="0" <% nvram_match( "ssr_dnsmode", "0","selected"); %>>dnsproxy全局模式</option>
<option value="1" <% nvram_match( "ssr_dnsmode", "1","selected"); %>>dnsproxy代理模式</option>
</select><a href=http://www.right.com.cn/Forum/thread-204802-1-1.html" target=_blank>&nbsp;&nbsp;&nbsp;【说明】</a>
</td>
</tr>
<tr>
<th>选择服务器</th>
<td>
<select id="ssr_index_id" name="ssr_index" class="input_option input_15_table">
<option value="0">无服务器配置</option>
</select>
</td>
</tr>
<tr>
<th>用户自定义</th>
<td>
<input class="button_gen" type="button" onClick="Add_userfile(0);" value="GFW列表">
<input class="button_gen" type="button" onClick="Add_userfile(1);" value="忽略IP段">
</td>
</tr>
</table>
</div>
<div id="hintBlock" style="width:650px;display:none;"></div>
<div id="mainTable" style="margin-top:10px;"></div>
<br>
<div id="ctrlBtn" style="text-align:center;"></div>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</table>
</td>
<td width="10" align="center" valign="top">&nbsp;</td>
</tr>
</table>
<div id="footer"></div>
</form>
</body>
</html>


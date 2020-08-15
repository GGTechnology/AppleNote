<?php
error_reporting(E_ALL ^ E_NOTICE);
//1
global $_GPC, $_W;
ini_set('date.timezone','Asia/Shanghai');

require_once "../lib/WxPay.Api.php";
require_once "WxPay.JsApiPay.php";
require_once 'log.php';


$tools = new JsApiPay();

$openId=$_GET['openid'];
$price=$_GET['price']*100;
$roomname=$_GET['roomname'];
$ordersn=$_GET['ordersn'];
$notifyUrl=$_GET['notifyUrl'];
//②、统一下单
$input = new WxPayUnifiedOrder();
$input->SetBody($roomname);
$input->SetAttach("111");
$input->SetOut_trade_no($ordersn);
$input->SetTotal_fee($price);
$input->SetTime_start(date("YmdHis"));
$input->SetTime_expire(date("YmdHis", time() + 600));
$input->SetGoods_tag("222");
$input->SetNotify_url($notifyUrl);
$input->SetTrade_type("JSAPI");
$input->SetOpenid($openId);
$order = WxPayApi::unifiedOrder($input);
$payStatus=1;
try{
    $jsApiParameters = $tools->GetJsApiParameters($order);

}
catch (Exception $e){
    $payStatus=0;
}

if($payStatus){
    echo $jsApiParameters;
}

//$editAddress = $tools->GetEditAddressParameters();




?>

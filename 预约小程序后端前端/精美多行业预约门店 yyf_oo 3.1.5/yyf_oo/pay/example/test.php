<?php
error_reporting(E_ALL ^ E_NOTICE);
$fileUrl=dirname(dirname(__FILE__));
$fileUrl=explode('pay',$fileUrl);
$uniacid=$fileUrl[1];
$url='https://'.$_SERVER['HTTP_HOST'].'/app/index.php?from=wxapp&c=entry&a=wxapp&do=PayNotify1&m=yyf_hotel&i='.$uniacid;
$res = file_get_contents("php://input");
$res =simplexml_load_string($res, 'SimpleXMLElement', LIBXML_NOCDATA);
$result_code = $res->result_code;
$return_code = $res->return_code;
$openid = $res->openid;
$out_trade_no = $res->out_trade_no;
$total_fee   = $res->total_fee;

if($result_code=='SUCCESS' && $return_code=='SUCCESS'){
    $data=array(
        'oid'=>$out_trade_no,
        'total'=>$total_fee,
        'openid'=>$openid
    );
    postData($data,$url);
}



function postData($post_data,$sendUrl){
    $post_data = json_encode($post_data);
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, $sendUrl);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);
    curl_setopt($curl, CURLOPT_POST, 1);
    curl_setopt($curl, CURLOPT_POSTFIELDS, $post_data);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    $result = curl_exec($curl);
    if (curl_errno($curl)) {
        return 'Errno'.curl_error($curl);
    }
    curl_close($curl);
    return $result;
}

?>

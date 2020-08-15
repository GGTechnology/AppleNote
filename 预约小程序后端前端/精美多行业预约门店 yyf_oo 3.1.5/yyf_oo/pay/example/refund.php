<?php
//require_once "../lib/WxPay.Api.php";

	function refund($total,$ordersn,$deposit){
		$out_trade_no = $ordersn;
		$total_fee = $total;
		$refund_fee = $deposit;
		$input = new WxPayRefund();
		$input->SetOut_trade_no($out_trade_no);
		$input->SetTotal_fee($total_fee);
		$input->SetRefund_fee($refund_fee);
	    $input->SetOut_refund_no(WxPayConfig::MCHID.date("YmdHis"));
	    $input->SetOp_user_id(WxPayConfig::MCHID);
		return WxPayApi::refund($input);
		
	}

?>
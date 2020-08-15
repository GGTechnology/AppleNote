<?php
		global $_W,$_GPC;
		$uniacid=$_W['uniacid'];
		load()->func('tpl');
		$result=pdo_fetch("SELECT * FROM ".tablename('yyf_oo_sysinfo')." where `uniacid`='$uniacid' order by id desc limit 1");
		$lng=$result['jing'];
		$lat=$result['wei'];
		$position=array('lng'=>$lng,'lat'=>$lat);
		$thumbs=pdo_fetchall("SELECT `thumb` FROM ".tablename('yyf_oo_thumb')." where `uniacid`='$uniacid' order by id desc");
		$images=array();
		foreach ($thumbs as $key => $value) {
			$images[]=$value['thumb'];
		}
		if(checksubmit()){
			$data=array();
			$data['name']=$_GPC['name'];
			$data['tel']=$_GPC['tel'];
			$position=$_GPC['position'];
			$arr=explode(',', $position);
			$data['jing']=$arr[0];
			$data['wei']=$arr[1];
			$data['address']=$_GPC['address'];
			$data['notice']=$_GPC['notice'];
			$data['desc']=$_GPC['desc'];
			$data['uniacid']=$_W['uniacid'];
			$data['reminder']=$_GPC['reminder'];
			$data['submitnum']=$_GPC['submitnum'];
			$data['backimg']=$_GPC['backimg'];
			$_GPC['is_arrival']=='on' ? $data['is_arrival']=1 : $data['is_arrival']=0;
			$result=pdo_fetch("SELECT `id` FROM ".tablename('yyf_oo_sysinfo')." where `uniacid`='$uniacid' order by id desc limit 1");
			if($result['id']){
				$hid=$result['id'];
				$res=pdo_update('yyf_oo_sysinfo',$data,array('id'=>$result['id']));
			}else{
				$res=pdo_insert('yyf_oo_sysinfo',$data);
			}
			//预先设置一下style这张表，以免用户没有设置首页样式后，前端全部隐藏的问题
			$styleRes=pdo_fetch("SELECT `id` FROM ".tablename('yyf_oo_style')." where `uniacid`='$uniacid' order by id desc limit 1");
			if(!$styleRes){
				$styleData=array(
					'uniacid'=>$uniacid,
					'show_slide'=>'1',
					'show_nav'=>'1',
					'show_tabbar'=>'1',
					'person_show'=>'1',
					'person_num'=>'4',
					'item_show'=>'1',
					'coupon_show'=>'1',
					'coupon_num'=>'4',
					'show_notice'=>'1'
				);
				pdo_insert('yyf_oo_style',$styleData);
			}

			if($_GPC['multi-image'][0]!=''){
				pdo_delete('yyf_oo_thumb',array('uniacid'=>$uniacid));
				foreach ($_GPC['multi-image'] as $key => $value) {
					pdo_insert('yyf_oo_thumb',array('uniacid'=>$uniacid,'thumb'=>$value));
				}
			}
			message('修改成功');
		}

		include $this->template('sysinfo');
?>
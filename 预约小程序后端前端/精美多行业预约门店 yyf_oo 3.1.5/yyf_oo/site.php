<?php
/**
 * 精美万能预约小程序模块微站定义
 *
 * @author QQ:295777501
 * 
 */
defined('IN_IA') or exit('Access Denied');

class Yyf_ooModuleSite extends WeModuleSite {
	public function doWebForm() {
		require_once dirname(__FILE__) . '/lib/lib_form.php';
	}

	public function doWebSysinfo() {
		require_once dirname(__FILE__) . '/lib/lib_sysinfo.php';
	}

	public function doWebCategory() {
		require_once dirname(__FILE__) . '/lib/lib_category.php';
	}

	public function doWebItem() {
		require_once dirname(__FILE__) . '/lib/lib_item.php';
	}

	//技师处理
	public function doWebPerson(){
		require_once dirname(__FILE__) . '/lib/lib_person.php';
	}
	public function doWebCoupon(){
		require_once dirname(__FILE__) . '/lib/lib_coupon.php';
	}
	public function doWebNotice(){
		require_once dirname(__FILE__) . '/lib/lib_notice.php';
	}
	public function doWebLevel(){
		require_once dirname(__FILE__) . '/lib/lib_level.php';
	}

	public function doWebStyle(){
		require_once dirname(__FILE__) . '/lib/lib_style.php';
	}

	public function doWebCopy(){
		require_once dirname(__FILE__) . '/lib/lib_copy.php';
	}

	public function doWebTabbar(){
		require_once dirname(__FILE__) . '/lib/lib_tabbar.php';
	}

    public function doWebOrder(){
        require_once dirname(__FILE__) . '/lib/lib_order.php';
    }

    public function doWebGroupOrder(){
        require_once dirname(__FILE__) . '/lib/lib_grouporder.php';
    }


    public function doWebOrderInfo(){
        require_once dirname(__FILE__) . '/lib/lib_orderinfo.php';
    }

    public function doWebRecharge(){
        require_once dirname(__FILE__) . '/lib/lib_recharge.php';
    }
    public function doWebSmtp(){
        require_once dirname(__FILE__) . '/lib/lib_smtp.php';
    }
    public function doWebMember(){
        require_once dirname(__FILE__) . '/lib/lib_member.php';
    }

    public function doWebComment(){
        require_once dirname(__FILE__) . '/lib/lib_comment.php';
    }

    public function doWebMould(){
        require_once dirname(__FILE__) . '/lib/lib_mould.php';
    }
    public function doWebShop() {
        require_once dirname(__FILE__) . '/lib/lib_shop.php';
    }

    public function doWebArrange() {
        require_once dirname(__FILE__) . '/lib/lib_arrange.php';
    }

    public function doWebPersonTime() {
        require_once dirname(__FILE__) . '/lib/lib_persontime.php';
    }

    public function doWebMiniInfo(){
        global $_W,$_GPC;
        include $this->template('miniinfo');
    }
    //门店处理函数
    private function handleShop($skind,$choiceArr){
        if($skind==0){
            return 0;
        }else{
            return implode(',',$choiceArr);
        }
    }

    public function doWebChoiceCatImg(){
        global $_W,$_GPC;
        $imgurl=MODULE_URL.'images/';
        include $this->template('choicecatimg');
    }

    public function doWebTitleExplain(){
        global $_W,$_GPC;
        $imgurl=MODULE_URL.'images/';
        include $this->template('titleexplain');
    }

    public function doWebNavExplain(){
        global $_W,$_GPC;
        $imgurl=MODULE_URL.'images/';
        include $this->template('navexplain');
    }

    private function orderStatus($status=0,$arrival){
        $status_str="";
        if($status==0){
            $status_str="<span class='label label-warning'>未支付</span>";
            if($arrival){$status_str="<span class='label label-warning'>到店支付</span>";}
        }elseif($status==1){
            $status_str="<span class='label label-success'>已支付</span>";
        }elseif($status==2){
            $status_str="<span class='label label-success'>已完成</span>";
        }elseif($status==3){
            $status_str="<span class='label label-danger'>已取消</span>";
        }elseif($status==4){
            $status_str="<span class='label label-danger'>已退款</span>";
        }

        return $status_str;
    }


    public function distance($lat1, $lng1, $lat2, $lng2, $miles = true)
    {
        $pi80 = M_PI / 180;
        $lat1 *= $pi80;
        $lng1 *= $pi80;
        $lat2 *= $pi80;
        $lng2 *= $pi80;
        $r = 6372.797; // mean radius of Earth in km
        $dlat = $lat2 - $lat1;
        $dlng = $lng2 - $lng1;
        $a = sin($dlat/2)*sin($dlat/2)+cos($lat1)*cos($lat2)*sin($dlng/2)*sin($dlng/2);
        $c = 2 * atan2(sqrt($a), sqrt(1 - $a));
        $km = $r * $c;
        return ($miles ? ($km * 0.621371192) : $km);
    }


	
}
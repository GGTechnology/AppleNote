<?php
//升级数据表
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_arrange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start` varchar(100) NOT NULL,
  `end` varchar(100) NOT NULL,
  `cid` int(11) NOT NULL,
  `people` int(11) unsigned NOT NULL,
  `week` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_arrange','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_arrange')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_arrange','start')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_arrange')." ADD   `start` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_arrange','end')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_arrange')." ADD   `end` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_arrange','cid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_arrange')." ADD   `cid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_arrange','people')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_arrange')." ADD   `people` int(11) unsigned NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_arrange','week')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_arrange')." ADD   `week` int(1) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_arrcat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `hide` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_arrcat','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_arrcat')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_arrcat','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_arrcat')." ADD   `uniacid` int(11) unsigned NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_arrcat','name')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_arrcat')." ADD   `name` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_arrcat','hide')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_arrcat')." ADD   `hide` int(1) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) NOT NULL,
  `sid` varchar(255) NOT NULL,
  `uniacid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `sortrank` int(11) NOT NULL,
  `type` int(2) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `isshow` int(2) NOT NULL,
  `content` text NOT NULL,
  `show_nav` int(11) NOT NULL,
  `show_num` int(11) NOT NULL DEFAULT '4',
  `show_navbar` int(2) NOT NULL,
  `thumb_height` int(5) NOT NULL DEFAULT '105',
  `cateurl` varchar(255) NOT NULL,
  `thumb_width` int(5) NOT NULL,
  `list_thumb` varchar(255) NOT NULL,
  `cid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_category','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_category','fid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `fid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','sid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `sid` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','name')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `name` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','sortrank')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `sortrank` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','type')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `type` int(2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','thumb')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `thumb` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','isshow')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `isshow` int(2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','content')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `content` text NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','show_nav')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `show_nav` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','show_num')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `show_num` int(11) NOT NULL DEFAULT '4'");}
if(!pdo_fieldexists('ims_yyf_oo_category','show_navbar')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `show_navbar` int(2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','thumb_height')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `thumb_height` int(5) NOT NULL DEFAULT '105'");}
if(!pdo_fieldexists('ims_yyf_oo_category','cateurl')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `cateurl` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','thumb_width')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `thumb_width` int(5) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','list_thumb')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `list_thumb` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_category','cid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_category')." ADD   `cid` int(11) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `openid` varchar(255) NOT NULL,
  `iid` int(11) NOT NULL,
  `score` varchar(10) NOT NULL,
  `content` varchar(255) NOT NULL,
  `addtime` int(10) NOT NULL,
  `pid` int(1) NOT NULL,
  `kind` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_comment','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_comment')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_comment','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_comment')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_comment','openid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_comment')." ADD   `openid` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_comment','iid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_comment')." ADD   `iid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_comment','score')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_comment')." ADD   `score` varchar(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_comment','content')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_comment')." ADD   `content` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_comment','addtime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_comment')." ADD   `addtime` int(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_comment','pid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_comment')." ADD   `pid` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_comment','kind')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_comment')." ADD   `kind` int(1) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `type` int(2) NOT NULL,
  `nums` int(11) NOT NULL,
  `condition` decimal(10,0) NOT NULL,
  `first` int(1) NOT NULL,
  `money` varchar(10) NOT NULL,
  `receive_num` int(5) NOT NULL,
  `receive_starttime` int(10) NOT NULL,
  `receive_endtime` int(10) NOT NULL,
  `active_starttime` int(10) NOT NULL,
  `active_endtime` int(10) NOT NULL,
  `score` int(11) NOT NULL,
  `sortrank` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_coupon','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','title')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `title` varchar(50) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','type')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `type` int(2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','nums')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `nums` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','condition')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `condition` decimal(10,0) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','first')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `first` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','money')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `money` varchar(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','receive_num')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `receive_num` int(5) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','receive_starttime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `receive_starttime` int(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','receive_endtime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `receive_endtime` int(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','active_starttime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `active_starttime` int(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','active_endtime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `active_endtime` int(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','score')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `score` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_coupon','sortrank')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_coupon')." ADD   `sortrank` int(11) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_form','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_form')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_form','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_form')." ADD   `uniacid` int(11) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_form18` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_form18','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_form18')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_form18','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_form18')." ADD   `uniacid` int(11) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(100) NOT NULL,
  `uniacid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `ptitle` varchar(100) NOT NULL,
  `pimg` varchar(150) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `groupprice` decimal(10,2) NOT NULL,
  `groupnums` int(11) NOT NULL,
  `grouptime` int(11) NOT NULL,
  `starttime` int(11) NOT NULL,
  `addnums` int(11) NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_group','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_group','openid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `openid` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_group','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_group','pid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `pid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_group','sid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `sid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_group','ptitle')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `ptitle` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_group','pimg')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `pimg` varchar(150) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_group','price')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `price` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_group','groupprice')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `groupprice` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_group','groupnums')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `groupnums` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_group','grouptime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `grouptime` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_group','starttime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `starttime` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_group','addnums')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `addnums` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_group','status')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_group')." ADD   `status` int(1) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_hard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `thumb` varchar(150) NOT NULL,
  `sid` int(11) NOT NULL COMMENT '门店id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_hard','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_hard')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_hard','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_hard')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_hard','name')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_hard')." ADD   `name` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_hard','thumb')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_hard')." ADD   `thumb` varchar(150) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_hard','sid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_hard')." ADD   `sid` int(11) NOT NULL COMMENT '门店id'");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `sid` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `sortrank` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `show` int(1) NOT NULL,
  `content` text NOT NULL,
  `videosrc` varchar(255) NOT NULL,
  `startgroup` int(1) NOT NULL,
  `groupnums` int(10) NOT NULL,
  `grouptime` int(10) NOT NULL,
  `groupprice` decimal(10,2) NOT NULL,
  `itemtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_item','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_item','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','cid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `cid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','sid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `sid` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','title')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `title` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','desc')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `desc` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','thumb')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `thumb` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','price')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `price` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','sortrank')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `sortrank` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','score')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `score` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','show')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `show` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','content')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `content` text NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','videosrc')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `videosrc` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','startgroup')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `startgroup` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','groupnums')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `groupnums` int(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','grouptime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `grouptime` int(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','groupprice')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `groupprice` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item','itemtime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item')." ADD   `itemtime` int(11) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_item_img` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iid` int(11) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_item_img','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item_img')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_item_img','iid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item_img')." ADD   `iid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_item_img','thumb')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_item_img')." ADD   `thumb` varchar(255) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `condition` decimal(10,2) NOT NULL,
  `sale` decimal(10,1) NOT NULL,
  `sortrank` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_level','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_level')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_level','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_level')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_level','name')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_level')." ADD   `name` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_level','thumb')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_level')." ADD   `thumb` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_level','condition')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_level')." ADD   `condition` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_level','sale')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_level')." ADD   `sale` decimal(10,1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_level','sortrank')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_level')." ADD   `sortrank` int(11) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oid` varchar(100) NOT NULL,
  `sid` int(11) NOT NULL,
  `paysn` varchar(100) NOT NULL,
  `weid` varchar(100) NOT NULL,
  `uniacid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `iid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `gid` int(10) NOT NULL,
  `startgroup` int(1) NOT NULL,
  `ititle` varchar(100) NOT NULL,
  `pname` varchar(100) NOT NULL,
  `openid` varchar(150) NOT NULL,
  `username` varchar(100) NOT NULL,
  `cometime` int(11) NOT NULL,
  `addtime` int(11) NOT NULL,
  `paytime` int(11) NOT NULL,
  `mode` int(2) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `status` int(11) NOT NULL,
  `groupstatus` int(1) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `mprice` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `couponmoney` decimal(10,2) NOT NULL,
  `arrival` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `comment_status` int(1) NOT NULL,
  `sale` decimal(10,1) NOT NULL,
  `diyform` varchar(255) NOT NULL,
  `orderdate` int(11) NOT NULL,
  `itemtime` int(11) NOT NULL,
  `item_status` int(1) NOT NULL,
  `person_status` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_order','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_order','oid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `oid` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','sid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `sid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','paysn')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `paysn` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','weid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `weid` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','pid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `pid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','iid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `iid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','cid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `cid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','gid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `gid` int(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','startgroup')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `startgroup` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','ititle')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `ititle` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','pname')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `pname` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','openid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `openid` varchar(150) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','username')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `username` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','cometime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `cometime` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','addtime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `addtime` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','paytime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `paytime` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','mode')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `mode` int(2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','phone')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `phone` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','status')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `status` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','groupstatus')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `groupstatus` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','price')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `price` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','mprice')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `mprice` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','total')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `total` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','couponmoney')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `couponmoney` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','arrival')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `arrival` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','score')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `score` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','comment_status')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `comment_status` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','sale')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `sale` decimal(10,1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','diyform')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `diyform` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','orderdate')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `orderdate` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','itemtime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `itemtime` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','item_status')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `item_status` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_order','person_status')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_order')." ADD   `person_status` int(1) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` varchar(255) NOT NULL,
  `uniacid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `skills` varchar(255) NOT NULL,
  `desc` text NOT NULL,
  `sortrank` int(11) NOT NULL,
  `start` varchar(255) NOT NULL,
  `end` varchar(255) NOT NULL,
  `show` int(1) NOT NULL,
  `aid` int(11) NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `message_email` varchar(255) NOT NULL,
  `smtp_email` varchar(255) NOT NULL,
  `smtp_key` varchar(255) NOT NULL,
  `message_title` varchar(255) NOT NULL,
  `sms_id` varchar(255) NOT NULL,
  `sms_key` varchar(255) NOT NULL,
  `sms_phone` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_person','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_person','sid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `sid` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','name')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `name` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','thumb')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `thumb` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','skills')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `skills` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','desc')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `desc` text NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','sortrank')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `sortrank` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','start')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `start` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','end')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `end` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','show')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `show` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','aid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `aid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','job_title')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `job_title` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','message_email')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `message_email` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','smtp_email')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `smtp_email` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','smtp_key')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `smtp_key` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','message_title')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `message_title` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','sms_id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `sms_id` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','sms_key')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `sms_key` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person','sms_phone')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person')." ADD   `sms_phone` varchar(255) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_person_img` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_person_img','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person_img')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_person_img','pid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person_img')." ADD   `pid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person_img','thumb')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person_img')." ADD   `thumb` varchar(255) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_person_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `iid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_person_item','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person_item')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_person_item','pid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person_item')." ADD   `pid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_person_item','iid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_person_item')." ADD   `iid` int(11) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `money` decimal(10,2) NOT NULL,
  `givemoney` decimal(10,2) NOT NULL,
  `gid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_recharge','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_recharge','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_recharge','money')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge')." ADD   `money` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_recharge','givemoney')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge')." ADD   `givemoney` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_recharge','gid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge')." ADD   `gid` int(11) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_recharge_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(255) NOT NULL,
  `oid` varchar(50) NOT NULL,
  `uniacid` int(11) NOT NULL,
  `status` int(1) NOT NULL,
  `gid` int(10) NOT NULL,
  `addtime` int(11) NOT NULL,
  `money` decimal(10,2) NOT NULL,
  `givemoney` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_recharge_log','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge_log')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_recharge_log','openid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge_log')." ADD   `openid` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_recharge_log','oid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge_log')." ADD   `oid` varchar(50) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_recharge_log','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge_log')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_recharge_log','status')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge_log')." ADD   `status` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_recharge_log','gid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge_log')." ADD   `gid` int(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_recharge_log','addtime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge_log')." ADD   `addtime` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_recharge_log','money')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge_log')." ADD   `money` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_recharge_log','givemoney')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_recharge_log')." ADD   `givemoney` decimal(10,2) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oid` varchar(255) NOT NULL,
  `openid` varchar(255) NOT NULL,
  `uniacid` int(11) NOT NULL,
  `addtime` int(11) NOT NULL,
  `score` int(255) NOT NULL,
  `exchange` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_score_log','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_score_log')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_score_log','oid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_score_log')." ADD   `oid` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_score_log','openid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_score_log')." ADD   `openid` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_score_log','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_score_log')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_score_log','addtime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_score_log')." ADD   `addtime` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_score_log','score')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_score_log')." ADD   `score` int(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_score_log','exchange')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_score_log')." ADD   `exchange` int(11) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `sortrank` int(11) NOT NULL,
  `switch` int(1) NOT NULL,
  `jing` varchar(100) NOT NULL,
  `wei` varchar(100) NOT NULL,
  `desc` text NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `message_email` varchar(255) NOT NULL,
  `smtp_email` varchar(255) NOT NULL,
  `smtp_key` varchar(255) NOT NULL,
  `message_title` varchar(255) NOT NULL,
  `sms_id` varchar(255) NOT NULL,
  `sms_key` varchar(255) NOT NULL,
  `sms_phone` varchar(255) NOT NULL,
  `printer_id` varchar(255) NOT NULL,
  `printer_key` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_shop','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_shop','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','name')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `name` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','phone')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `phone` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','address')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `address` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','sortrank')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `sortrank` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','switch')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `switch` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','jing')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `jing` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','wei')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `wei` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','desc')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `desc` text NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','thumb')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `thumb` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','message_email')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `message_email` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','smtp_email')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `smtp_email` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','smtp_key')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `smtp_key` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','message_title')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `message_title` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','sms_id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `sms_id` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','sms_key')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `sms_key` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','sms_phone')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `sms_phone` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','printer_id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `printer_id` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_shop','printer_key')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_shop')." ADD   `printer_key` varchar(255) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_style` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `tcolor` varchar(100) NOT NULL,
  `show_slide` int(1) NOT NULL,
  `show_nav` int(1) NOT NULL,
  `show_notice` int(1) NOT NULL,
  `slide_height` varchar(50) NOT NULL,
  `nav_style` int(11) NOT NULL,
  `title_style` int(11) NOT NULL,
  `show_tabbar` int(1) NOT NULL,
  `nav_height` varchar(255) NOT NULL,
  `head_color` varchar(255) NOT NULL,
  `font_color` varchar(255) NOT NULL,
  `person_show` int(1) NOT NULL,
  `person_num` int(11) NOT NULL,
  `person_sortrank` int(11) NOT NULL,
  `item_show` int(1) NOT NULL,
  `item_sortrank` int(11) NOT NULL,
  `coupon_show` int(1) NOT NULL,
  `coupon_num` int(11) NOT NULL,
  `coupon_sortrank` int(11) NOT NULL,
  `horn` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_style','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_style','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','tcolor')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `tcolor` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','show_slide')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `show_slide` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','show_nav')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `show_nav` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','show_notice')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `show_notice` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','slide_height')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `slide_height` varchar(50) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','nav_style')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `nav_style` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','title_style')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `title_style` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','show_tabbar')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `show_tabbar` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','nav_height')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `nav_height` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','head_color')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `head_color` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','font_color')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `font_color` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','person_show')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `person_show` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','person_num')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `person_num` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','person_sortrank')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `person_sortrank` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','item_show')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `item_show` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','item_sortrank')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `item_sortrank` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','coupon_show')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `coupon_show` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','coupon_num')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `coupon_num` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','coupon_sortrank')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `coupon_sortrank` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_style','horn')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_style')." ADD   `horn` varchar(255) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_sysinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `multi` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `jing` varchar(150) NOT NULL,
  `wei` varchar(150) NOT NULL,
  `notice` varchar(255) NOT NULL,
  `desc` text NOT NULL,
  `reminder` varchar(255) NOT NULL,
  `message_email` varchar(255) NOT NULL,
  `submitnum` int(11) NOT NULL,
  `backimg` varchar(255) NOT NULL,
  `smtp_email` varchar(255) NOT NULL,
  `smtp_key` varchar(255) NOT NULL,
  `message_title` varchar(255) NOT NULL,
  `copyright` varchar(255) NOT NULL,
  `copy_appid` varchar(255) NOT NULL,
  `copy_address` varchar(255) NOT NULL,
  `copy_img` varchar(255) NOT NULL,
  `copy_phone` varchar(255) NOT NULL,
  `copy_kind` int(11) NOT NULL,
  `is_arrival` int(11) NOT NULL DEFAULT '1',
  `sms_id` varchar(255) NOT NULL,
  `sms_key` varchar(255) NOT NULL,
  `printer_id` varchar(255) NOT NULL,
  `printer_key` varchar(255) NOT NULL,
  `sms_phone` varchar(255) NOT NULL,
  `templet_id` varchar(255) NOT NULL,
  `show_person` int(1) NOT NULL DEFAULT '1',
  `person_name` varchar(50) NOT NULL,
  `close_pay` int(1) NOT NULL,
  `hide_price` int(1) NOT NULL,
  `certpem` text NOT NULL,
  `keypem` text NOT NULL,
  `start_arrange` int(1) NOT NULL,
  `start_mustpeo` int(1) NOT NULL,
  `close_people_comment` tinyint(1) NOT NULL,
  `close_item_comment` tinyint(1) NOT NULL,
  `month_most_order` int(11) NOT NULL DEFAULT '20' COMMENT '当月个人最大下单数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_sysinfo','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','multi')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `multi` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','name')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `name` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','phone')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `phone` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','address')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `address` varchar(200) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','jing')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `jing` varchar(150) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','wei')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `wei` varchar(150) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','notice')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `notice` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','desc')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `desc` text NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','reminder')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `reminder` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','message_email')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `message_email` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','submitnum')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `submitnum` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','backimg')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `backimg` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','smtp_email')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `smtp_email` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','smtp_key')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `smtp_key` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','message_title')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `message_title` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','copyright')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `copyright` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','copy_appid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `copy_appid` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','copy_address')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `copy_address` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','copy_img')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `copy_img` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','copy_phone')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `copy_phone` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','copy_kind')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `copy_kind` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','is_arrival')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `is_arrival` int(11) NOT NULL DEFAULT '1'");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','sms_id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `sms_id` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','sms_key')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `sms_key` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','printer_id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `printer_id` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','printer_key')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `printer_key` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','sms_phone')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `sms_phone` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','templet_id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `templet_id` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','show_person')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `show_person` int(1) NOT NULL DEFAULT '1'");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','person_name')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `person_name` varchar(50) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','close_pay')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `close_pay` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','hide_price')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `hide_price` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','certpem')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `certpem` text NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','keypem')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `keypem` text NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','start_arrange')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `start_arrange` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','start_mustpeo')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `start_mustpeo` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','close_people_comment')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `close_people_comment` tinyint(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','close_item_comment')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `close_item_comment` tinyint(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_sysinfo','month_most_order')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_sysinfo')." ADD   `month_most_order` int(11) NOT NULL DEFAULT '20' COMMENT '当月个人最大下单数'");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_tabbar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `m1_name` varchar(255) NOT NULL,
  `m2_name` varchar(255) NOT NULL,
  `m3_name` varchar(255) NOT NULL,
  `m4_name` varchar(255) NOT NULL,
  `m1_path` varchar(255) NOT NULL,
  `m2_path` varchar(255) NOT NULL,
  `m3_path` varchar(255) NOT NULL,
  `m4_path` varchar(255) NOT NULL,
  `m1_img` varchar(255) NOT NULL,
  `m2_img` varchar(255) NOT NULL,
  `m3_img` varchar(255) NOT NULL,
  `m4_img` varchar(255) NOT NULL,
  `m1_selimg` varchar(255) NOT NULL,
  `m2_selimg` varchar(255) NOT NULL,
  `m3_selimg` varchar(255) NOT NULL,
  `m4_selimg` varchar(255) NOT NULL,
  `border_color` varchar(255) NOT NULL,
  `background_color` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `sel_color` varchar(255) NOT NULL,
  `uptime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_tabbar','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m1_name')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m1_name` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m2_name')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m2_name` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m3_name')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m3_name` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m4_name')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m4_name` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m1_path')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m1_path` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m2_path')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m2_path` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m3_path')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m3_path` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m4_path')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m4_path` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m1_img')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m1_img` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m2_img')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m2_img` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m3_img')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m3_img` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m4_img')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m4_img` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m1_selimg')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m1_selimg` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m2_selimg')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m2_selimg` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m3_selimg')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m3_selimg` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','m4_selimg')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `m4_selimg` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','border_color')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `border_color` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','background_color')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `background_color` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','color')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `color` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','sel_color')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `sel_color` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_tabbar','uptime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_tabbar')." ADD   `uptime` int(11) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_thumb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kid` int(11) NOT NULL,
  `uniacid` int(11) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `sid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_thumb','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_thumb')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_thumb','kid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_thumb')." ADD   `kid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_thumb','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_thumb')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_thumb','thumb')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_thumb')." ADD   `thumb` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_thumb','sid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_thumb')." ADD   `sid` int(11) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `openid` varchar(100) NOT NULL,
  `gid` int(10) NOT NULL,
  `nickname` varchar(100) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `city` varchar(50) NOT NULL,
  `province` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `addtime` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `isadmin` int(2) NOT NULL,
  `username` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `confirm_userinfo` int(1) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `money` decimal(10,2) NOT NULL,
  `sid` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_user','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_user','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','openid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `openid` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','gid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `gid` int(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','nickname')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `nickname` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','avatar')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `avatar` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','city')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `city` varchar(50) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','province')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `province` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','country')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `country` varchar(100) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','gender')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `gender` varchar(10) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','addtime')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `addtime` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','score')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `score` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','isadmin')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `isadmin` int(2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','username')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `username` varchar(50) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','phone')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `phone` varchar(50) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','confirm_userinfo')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `confirm_userinfo` int(1) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','total')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `total` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','money')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `money` decimal(10,2) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user','sid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user')." ADD   `sid` varchar(255) NOT NULL");}
pdo_query("CREATE TABLE IF NOT EXISTS `ims_yyf_oo_user_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `openid` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

");

if(!pdo_fieldexists('ims_yyf_oo_user_coupon','id')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user_coupon')." ADD 
  `id` int(11) NOT NULL AUTO_INCREMENT");}
if(!pdo_fieldexists('ims_yyf_oo_user_coupon','uniacid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user_coupon')." ADD   `uniacid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user_coupon','cid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user_coupon')." ADD   `cid` int(11) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user_coupon','openid')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user_coupon')." ADD   `openid` varchar(255) NOT NULL");}
if(!pdo_fieldexists('ims_yyf_oo_user_coupon','status')) {pdo_query("ALTER TABLE ".tablename('ims_yyf_oo_user_coupon')." ADD   `status` int(11) NOT NULL");}

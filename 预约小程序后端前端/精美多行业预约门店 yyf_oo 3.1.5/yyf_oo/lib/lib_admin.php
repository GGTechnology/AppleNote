<?php
 goto qYHoA; mC_4y: foreach ($shopArr as $k => $v) { goto UPKlu; GQQJe: $shopArr[$k]["\143\150\x65\143\x6b\145\x64"] = 1; goto ohwBo; UPKlu: if (!in_array($v["\x69\144"], $checkArr)) { goto elrbe; } goto GQQJe; ohwBo: elrbe: goto YKXPa; YKXPa: NT494: goto CoIz7; CoIz7: } goto swRqu; kBXkc: hjHT2: goto alJJR; F2_rO: $p = ($pageindex - 1) * 15; goto voHOj; oxZ6Q: $uniacid = $_W["\x75\156\151\x61\x63\151\144"]; goto Rv2m9; VSl4c: $pager = pagination($total, $pageindex, $pagesize); goto F2_rO; OindY: if ($op == "\163\x65\x74") { goto Ba2ir; } goto ym2J2; FhTTe: include $this->template("\x61\x64\155\151\156\163\145\164"); goto nQG6L; NCkOy: $id = $_GPC["\165\151\x64"]; goto KHP05; KHP05: $data["\163\x69\144"] = $this->handleShop($_GPC["\163\x6b\x69\x6e\144"], $_GPC["\x73\151\144"]); goto E6KH1; aKEIv: g26Po: goto KLxy3; jcUvL: p9mNh: goto fS8LI; alJJR: $keyword = $_GPC["\153\x65\171\167\157\x72\x64"]; goto PYqRr; QylNu: pdo_update("\171\171\x66\x5f\x6f\157\x5f\x75\163\145\162", $data, array("\x69\x64" => $id)); goto oysP3; pf3JA: goto kgVor; goto LEOl1; TdIUw: goto g26Po; goto kBXkc; fS8LI: if (!checksubmit()) { goto ToJSz; } goto NCkOy; PYqRr: $where .= "\x20\x61\x6e\x64\40\140\x6e\x69\143\x6b\x6e\x61\x6d\x65\x60\x20\x6c\x69\x6b\145\40\47\x25{$keyword}\x25\47"; goto aKEIv; a0qAl: goto w4S32; goto QU8Xh; lid4B: $op = $_GPC["\x6f\x70"]; goto OindY; PcWAz: w4S32: goto E7UNd; B8BQs: $pageindex = 1; goto PcWAz; XYGeY: $total = count($participators); goto WmGWJ; E7UNd: $pagesize = 15; goto VSl4c; KLxy3: $participators = pdo_fetchall("\x53\105\x4c\x45\x43\x54\40\52\40\106\122\117\x4d\x20" . tablename("\x79\171\x66\x5f\157\157\137\165\163\x65\162") . "\x20\167\x68\145\162\145\x20{$where}\40\x6f\x72\x64\x65\162\40\142\171\x20\151\144\40\x64\x65\163\x63"); goto XYGeY; Jmbbr: $pageindex = intval($_GPC["\x70\x61\x67\x65"]); goto a0qAl; tCn8a: $isadmin = $_GPC["\151\x73\x61\x64\155\151\x6e"]; goto lid4B; Gj8X8: ToJSz: goto FhTTe; voHOj: $list = pdo_fetchall("\x53\105\x4c\105\x43\124\40\x2a\x20\x46\122\117\x4d\x20" . tablename("\171\x79\146\137\x6f\157\x5f\165\x73\145\x72") . "\40\167\150\x65\162\x65\40{$where}\x20\157\162\144\145\x72\40\x62\171\x20\x69\144\40\144\145\163\x63\x20\154\x69\155\x69\164\x20" . $p . "\54" . $pagesize); goto kLUmN; QU8Xh: oyobs: goto B8BQs; Rv2m9: $where = "\x60\x75\x6e\x69\x61\143\151\144\140\x3d\47{$uniacid}\x27"; goto xdpBF; kLUmN: include $this->template("\141\x64\155\151\x6e"); goto pf3JA; qYHoA: global $_W, $_GPC; goto oxZ6Q; Z97GZ: $data = pdo_get("\171\171\x66\137\x6f\x6f\x5f\165\x73\x65\162", array("\151\144" => $id)); goto LzhFy; xdpBF: $uid = $_GPC["\165\151\144"]; goto tCn8a; vXDKL: $checkArr = explode("\54", $data["\163\151\x64"]); goto mC_4y; swRqu: K3VnL: goto jcUvL; TN79O: $id = $_GPC["\165\151\144"]; goto yukRl; LzhFy: if (!$data["\x73\151\x64"]) { goto p9mNh; } goto vXDKL; ycPDa: $where .= "\x20\x61\x6e\144\x20\x60\151\x73\141\144\x6d\x69\x6e\140\x3d\x27\61\x27"; goto TdIUw; E6KH1: $_GPC["\151\163\141\x64\155\x69\156"] == "\x6f\156" ? $data["\151\163\141\144\x6d\x69\156"] = 1 : ($data["\151\163\x61\144\x6d\x69\156"] = 0); goto QylNu; LEOl1: Ba2ir: goto TN79O; ym2J2: if (checksubmit()) { goto hjHT2; } goto ycPDa; yukRl: $shopArr = pdo_getall("\x79\x79\x66\137\157\157\137\x73\150\x6f\x70", array("\x75\156\x69\x61\143\x69\144" => $uniacid), array("\151\x64", "\156\141\x6d\x65")); goto Z97GZ; WmGWJ: if (!isset($_GPC["\x70\141\x67\145"])) { goto oyobs; } goto Jmbbr; oysP3: message("\xe6\xb7\273\xe5\x8a\240\346\212\x80\345\270\x88\346\210\x90\345\x8a\237", $this->createWebUrl("\141\144\x6d\151\x6e", array("\x6f\x70" => "\154\x69\x73\164"))); goto Gj8X8; nQG6L: kgVor:
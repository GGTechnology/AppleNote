<?php
 goto r2WTv; r2WTv: global $_W, $_GPC; goto qLUSq; nmLKf: $map = ''; goto xGHSK; s80Ve: if (!$_GPC["\151\x64"]) { goto JwVLh; } goto xhQaZ; tqmvz: $kind = $_GPC["\153\151\x6e\144"]; goto PPIvf; pxneE: $participators = pdo_fetchall("\x53\x45\114\x45\103\x54\x20\x2a\x20\106\x52\117\x4d\40" . tablename("\171\x79\x66\137\x6f\157\x5f\x63\157\x6d\x6d\x65\x6e\164") . "\x20\167\x68\x65\162\145\40\x60\x75\x6e\x69\141\143\x69\x64\140\75\47{$uniacid}\x27{$map}\x20\x6f\162\x64\x65\x72\40\x62\x79\40\151\144\40\x64\x65\x73\143"); goto bSy4K; O6_Zc: goto vi68f; goto NqdjX; ztRue: if (!isset($_GPC["\160\x61\x67\x65"])) { goto mzrOO; } goto JXbf8; yWxXi: foreach ($list as $key => $value) { goto Zo37l; Zo37l: $where["\157\160\x65\156\151\x64"] = $value["\x6f\160\145\x6e\151\144"]; goto qNCBW; HNWy4: $list[$key]["\144\x61\x74\x65"] = date("\x6d\55\x64", $value["\141\144\144\164\151\x6d\145"]); goto u14xY; JGK8q: $list[$key]["\x6b\145\x79"] = $value["\163\x63\157\162\145"]; goto rzFMW; qNCBW: $row = pdo_get("\171\x79\146\x5f\x6f\x6f\137\165\163\x65\x72", $where); goto JGK8q; u14xY: $list[$key]["\156\x61\x6d\x65"] = pdo_getcolumn("\x79\x79\x66\x5f\157\157\x5f\x69\164\x65\155", array("\x69\x64" => $value["\151\x69\x64"]), "\x74\x69\x74\154\145"); goto poVoz; poVoz: $pid = $value["\x70\x69\x64"]; goto o1z88; UF4BM: $list[$key]["\x6e\151\143\153\x6e\x61\155\x65"] = $row["\156\151\x63\153\156\x61\155\145"]; goto HNWy4; rzFMW: $list[$key]["\141\166\x61\164\141\x72"] = $row["\141\166\141\164\141\x72"]; goto UF4BM; gRVaH: r7jW9: goto dJG3z; o1z88: $list[$key]["\160\156\141\155\145"] = pdo_getcolumn("\171\171\x66\x5f\x6f\x6f\x5f\x70\145\162\x73\157\156", array("\151\x64" => $pid), "\x6e\x61\x6d\145"); goto gRVaH; dJG3z: } goto pSwyX; yGbyV: $pager = pagination($total, $pageindex, $pagesize); goto y5Ma2; tEcVC: include $this->template("\x63\157\155\155\x65\156\164"); goto yxc3H; yxc3H: goto rBnWe; goto Q3LoI; R0eRL: $pagesize = 15; goto yGbyV; PPIvf: if ($kind != "\55\x31") { goto a7OVe; } goto nmLKf; Q3LoI: YeBRu: goto s80Ve; goZ1N: if ($op == "\x64\x65\x6c") { goto YeBRu; } goto tqmvz; Ew_y1: $list = pdo_fetchall("\123\105\x4c\105\x43\x54\x20\x2a\40\106\x52\117\115\40" . tablename("\171\171\146\x5f\x6f\157\x5f\x63\x6f\x6d\155\x65\x6e\x74") . "\x20\167\x68\x65\162\x65\40\140\x75\x6e\151\141\x63\x69\x64\140\x3d\47{$uniacid}\x27{$map}\x20\157\162\144\145\162\40\x62\171\x20\x69\x64\x20\x64\x65\163\x63\40\x6c\x69\155\x69\164\40" . $p . "\x2c" . $pagesize); goto yWxXi; i3Sky: a7OVe: goto qnhIl; xGHSK: goto q9Dtm; goto i3Sky; VgNh9: JwVLh: goto o5eq5; o5eq5: include $this->template("\143\x6f\155\155\x65\x6e\x74"); goto Em23C; pSwyX: MveFk: goto tEcVC; raCDE: $op = $_GPC["\x6f\x70"]; goto goZ1N; bSy4K: $total = count($participators); goto ztRue; iUpGS: $pageindex = 1; goto OQuo1; JXbf8: $pageindex = intval($_GPC["\160\141\147\145"]); goto O6_Zc; qnhIl: $map = "\x20\141\156\144\x20\140\x6b\151\x6e\x64\x60\x3d" . "\47" . $_GPC["\x6b\151\x6e\x64"] . "\x27"; goto cfQyg; vPsBG: message("\345\x88\xa0\xe9\x99\xa4\xe6\x88\x90\xe5\212\237", $this->createWebUrl("\103\x6f\x6d\x6d\145\156\x74", array("\157\160" => "\x6c\151\163\164"))); goto VgNh9; NqdjX: mzrOO: goto iUpGS; cfQyg: q9Dtm: goto pxneE; y5Ma2: $p = ($pageindex - 1) * 15; goto Ew_y1; xhQaZ: $id = $_GPC["\151\x64"]; goto CBPFI; OQuo1: vi68f: goto R0eRL; qLUSq: $uniacid = $_W["\x75\156\x69\141\x63\x69\144"]; goto raCDE; CBPFI: $data = pdo_delete("\x79\x79\x66\x5f\x6f\157\x5f\x63\x6f\x6d\x6d\x65\x6e\164", array("\151\144" => $id, "\165\156\151\x61\x63\x69\144" => $uniacid)); goto vPsBG; Em23C: rBnWe:
var t = getApp();

Page({
    data: {
        style: [],
        list: [],
        blist: {},
        money: 0,
        rid: 0,
        chargeMoney: "0"
    },
    onLoad: function(t) {
        this.tabbar();
    },
    onShow: function() {
        this.getContent();
    },
    getContent: function() {
        var a = this, e = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/recharge",
            data: {
                m: "yyf_oo",
                uniacid: e
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || a.setData({
                    money: t.data.data.money,
                    list: t.data.data.list
                });
            }
        });
    },
    clickCharge: function(t) {
        var a = t.currentTarget.dataset.lid, e = this.data.list, i = e[a].checked;
        i = "0" == i ? "1" : "0", e[a].checked = i;
        for (var n = 0; n < e.length; n++) e[n].id != e[a].id && (e[n].checked = "0");
        this.setData({
            list: e
        });
    },
    chargeAction: function(t) {
        var a = t.detail.value;
        this.setData({
            chargeMoney: a
        });
    },
    submitAction: function(t) {
        console.log("11");
        for (var a = this.data.list, e = 0, i = 0; i < a.length; i++) "1" == a[i].checked && (e = a[i].id);
        var n = this.data.chargeMoney;
        if ("0" == e && (!/^(\-?\d+(\.\d+)?)$/.test(n) || n <= 0)) return this.notice("充值金额不正确!"), 
        !1;
        this.handlePay(e, n);
    },
    handlePay: function(a, e) {
        var i = this, n = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/Recharge",
            data: {
                m: "yyf_oo",
                uniacid: n,
                gid: a,
                money: e,
                op: "recharge"
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || i.paying(t.data.data.oid, t.data.data.money, n);
            }
        });
    },
    paying: function(a, e, i) {
        var n = this;
        t.util.request({
            url: "entry/wxapp/Recharge",
            data: {
                m: "yyf_oo",
                uniacid: i,
                money: e,
                ordersn: a,
                op: "pay"
            },
            header: {
                "content-type": "application/json"
            },
            success: function(t) {
                wx.requestPayment({
                    timeStamp: t.data.data.timeStamp,
                    nonceStr: t.data.data.nonceStr,
                    package: t.data.data.package,
                    signType: "MD5",
                    paySign: t.data.data.paySign,
                    success: function(t) {
                        n.notice("充值成功"), n.getContent();
                    },
                    fail: function(t) {}
                });
            },
            fail: function(t) {
                n.notice("微信支付失败！");
            }
        });
    },
    tabbar: function() {
        var a = this, e = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/tabbar",
            data: {
                m: "yyf_oo",
                uniacid: e
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) {
                    var e = wx.getStorageSync("barlist");
                    "" != e && e.uptime == t.data.data.uptime || wx.setStorageSync("barlist", t.data.data), 
                    a.setTabBar();
                }
            }
        });
    },
    setTabBar: function(t) {
        if (!(o = wx.getStorageSync("barlist"))) return !1;
        this.setData({
            blist: o,
            tcolor: o.tcolor,
            hide_tabbar: o.hide_tabbar,
            style: o.style
        });
        var a, e;
        a = "" != o.font_color ? o.font_color : "#ffffff", e = "" != o.head_color ? o.head_color : o.tcolor, 
        wx.setNavigationBarColor({
            frontColor: a,
            backgroundColor: e
        });
        var i = getCurrentPages(), n = i[i.length - 1], o = this.data.blist;
        n.options.tid == t && (o.isCurrentPage = !0);
        var r = new Array(o.m1_path, o.m2_path, o.m3_path, o.m4_path), s = 0;
        for (var c in r) r[c] == t && (s = parseInt(c) + 1);
        o.currentNum = s, this.setData({
            blist: o
        });
    },
    tel: function() {
        var t = this.data.blist.phone;
        wx.makePhoneCall({
            phoneNumber: t
        });
    },
    driver: function() {
        wx.openLocation({
            latitude: Number(this.data.blist.jing),
            longitude: Number(this.data.blist.wei),
            address: this.data.blist.address
        });
    },
    navigateMini: function(t) {
        var a = t.currentTarget.dataset.sid;
        this.data.list[a].appid, this.data.list[a].pageaddress;
    },
    tabNav: function(t) {
        var a = t.currentTarget.dataset.url, e = t.currentTarget.dataset.tab;
        if ("-1" != a.indexOf("https")) {
            wx.setStorageSync("navurl", a);
            a = "../webview/webview?op=" + e;
            wx.navigateTo({
                url: a
            });
        } else wx.navigateTo({
            url: a
        });
    },
    copy_action: function() {
        var t = this.data.blist.copyright;
        if ("1" == t.copy_kind) {
            var a = t.copy_phone;
            wx.makePhoneCall({
                phoneNumber: a
            });
        }
    },
    notice: function(t) {
        wx.showModal({
            title: t,
            content: "",
            success: function(t) {}
        });
    }
});
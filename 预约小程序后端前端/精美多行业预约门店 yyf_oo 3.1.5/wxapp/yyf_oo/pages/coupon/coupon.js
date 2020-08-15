var t = getApp();

Page({
    data: {
        list: [],
        isnull: 0,
        style: []
    },
    onLoad: function(t) {
        this.tabbar(), this.loadData(0);
    },
    onPullDownRefresh: function() {
        wx.showNavigationBarLoading(), this.loadData("1"), wx.hideNavigationBarLoading(), 
        wx.stopPullDownRefresh();
    },
    loadData: function(a) {
        var o = this, e = t.siteInfo.uniacid, r = wx.getStorageSync("openid");
        t.util.request({
            url: "entry/wxapp/coupon",
            data: {
                m: "yyf_oo",
                uniacid: e,
                op: "list",
                openid: r
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) {
                    var a = t.data.data.style;
                    o.setData({
                        list: t.data.data.list,
                        isnull: t.data.data.isnull,
                        style: a
                    });
                    var e, r;
                    e = "" != a.font_color ? a.font_color : "#ffffff", r = "" != a.head_color ? a.head_color : a.tcolor, 
                    wx.setNavigationBarColor({
                        frontColor: e,
                        backgroundColor: r
                    });
                }
            }
        });
    },
    receive_btn: function(a) {
        var o = this, e = t.siteInfo.uniacid, r = parseInt(a.currentTarget.dataset.cid), n = wx.getStorageSync("openid");
        t.util.request({
            url: "entry/wxapp/coupon",
            data: {
                m: "yyf_oo",
                uniacid: e,
                op: "receive",
                id: r,
                openid: n
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno ? wx.showToast({
                    title: t.data.message
                }) : (wx.showModal({
                    title: "领取成功",
                    content: "可以在会员中心里查看"
                }), o.setData({
                    list: t.data.data
                }));
            }
        });
    },
    onShareAppMessage: function(t) {
        return {
            title: "优惠券",
            path: "/yyf_oo/pages/coupon/coupon"
        };
    },
    tabbar: function() {
        var a = this, o = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/tabbar",
            data: {
                m: "yyf_oo",
                uniacid: o
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) {
                    var o = wx.getStorageSync("barlist");
                    "" != o && o.uptime == t.data.data.uptime || wx.setStorageSync("barlist", t.data.data), 
                    a.setTabBar();
                }
            }
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
    setTabBar: function(t) {
        if (!(n = wx.getStorageSync("barlist"))) return !1;
        this.setData({
            blist: n,
            tcolor: n.tcolor,
            hide_tabbar: n.hide_tabbar,
            style: n.style
        });
        var a, o;
        a = "" != n.font_color ? n.font_color : "#ffffff", o = "" != n.head_color ? n.head_color : n.tcolor, 
        wx.setNavigationBarColor({
            frontColor: a,
            backgroundColor: o
        });
        var e = getCurrentPages(), r = e[e.length - 1].route, n = this.data.blist, i = r.split("/");
        "coupon" == i[i.length - 1] && (n.isCurrentPage = !0);
        var s = new Array(n.m1_path, n.m2_path, n.m3_path, n.m4_path), c = 0;
        for (var l in s) "coupon" == s[l] && (c = parseInt(l) + 1);
        n.currentNum = c, this.setData({
            blist: n
        });
    },
    tabNav: function(t) {
        var a = t.currentTarget.dataset.url, o = t.currentTarget.dataset.tab;
        if ("-1" != a.indexOf("https")) {
            wx.setStorageSync("navurl", a);
            a = "../webview/webview?op=" + o;
            wx.navigateTo({
                url: a
            });
        } else wx.navigateTo({
            url: a
        });
    }
});
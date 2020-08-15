var t = getApp();

Page({
    data: {
        list: {}
    },
    onLoad: function(a) {
        this.tabbar();
        var e = this, r = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/person",
            data: {
                m: "yyf_oo",
                uniacid: r,
                op: "list"
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || (e.setData({
                    list: t.data.data.personlist
                }), wx.setNavigationBarTitle({
                    title: t.data.data.person_name
                }));
            }
        });
    },
    navPerson: function(t) {
        var a = t.currentTarget.dataset.pid;
        wx.navigateTo({
            url: "../persondetails/persondetails?id=" + a
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
        var r = getCurrentPages(), i = r[r.length - 1].route, o = this.data.blist, n = i.split("/");
        "person" == n[n.length - 1] && (o.isCurrentPage = !0);
        var s = new Array(o.m1_path, o.m2_path, o.m3_path, o.m4_path), c = 0;
        for (var l in s) "person" == s[l] && (c = parseInt(l) + 1);
        o.currentNum = c, this.setData({
            blist: o
        });
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
    }
});
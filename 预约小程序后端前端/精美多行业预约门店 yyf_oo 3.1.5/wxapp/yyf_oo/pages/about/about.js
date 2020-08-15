var t = getApp();

Page({
    data: {
        list: {},
        address: "",
        imageCount: 0
    },
    onLoad: function(a) {
        var e;
        e = void 0 == a.sid ? wx.getStorageSync("sid") : a.sid;
        var r = this, i = t.siteInfo.uniacid;
        this.tabbar(), t.util.request({
            url: "entry/wxapp/About",
            data: {
                m: "yyf_oo",
                uniacid: i,
                sid: e
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || (t.data.data.thumbs && r.setData({
                    currentImage: t.data.data.thumbs[0],
                    imageCount: t.data.data.thumbs.length
                }), r.setData({
                    list: t.data.data
                }));
            }
        });
    },
    onShareAppMessage: function(t) {
        var a, e;
        return e = wx.getStorageSync("sid"), a = "" != e && e ? "/yyf_oo/pages/about/index?sid=" + e : "/yyf_oo/pages/about/index", 
        {
            title: this.data.sysinfo.name,
            path: a
        };
    },
    previewImage: function(t) {
        var a = t.currentTarget.dataset.index, e = this.data.list.thumbs;
        wx.previewImage({
            current: e[a],
            urls: e
        });
    },
    gotoAddress: function() {
        var t = wx.getStorageSync("jing"), a = wx.getStorageSync("wei");
        wx.openLocation({
            latitude: Number(t),
            longitude: Number(a),
            address: this.data.address
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
        "about" == n[n.length - 1] && (o.isCurrentPage = !0);
        var s = new Array(o.m1_path, o.m2_path, o.m3_path, o.m4_path), u = 0;
        for (var d in s) "about" == s[d] && (u = parseInt(d) + 1);
        o.currentNum = u, this.setData({
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
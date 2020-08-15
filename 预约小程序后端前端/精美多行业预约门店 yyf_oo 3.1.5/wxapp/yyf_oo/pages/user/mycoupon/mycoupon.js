var t = getApp();

Page({
    data: {
        list: [],
        isnull: 0,
        blist: {}
    },
    onLoad: function(a) {
        this.tabbar();
        var r = this, i = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/coupon",
            data: {
                m: "yyf_oo",
                uniacid: i,
                op: "getuserlist"
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || r.setData({
                    list: t.data.data.list,
                    isnull: t.data.data.isnull
                });
            }
        });
    },
    tabbar: function() {
        var a = this, r = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/tabbar",
            data: {
                m: "yyf_oo",
                uniacid: r
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) {
                    var r = wx.getStorageSync("barlist");
                    "" != r && r.uptime == t.data.data.uptime || wx.setStorageSync("barlist", t.data.data), 
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
        var a, r;
        a = "" != o.font_color ? o.font_color : "#ffffff", r = "" != o.head_color ? o.head_color : o.tcolor, 
        wx.setNavigationBarColor({
            frontColor: a,
            backgroundColor: r
        });
        var i = getCurrentPages(), e = i[i.length - 1], o = this.data.blist;
        e.options.tid == t && (o.isCurrentPage = !0);
        var s = new Array(o.m1_path, o.m2_path, o.m3_path, o.m4_path), n = 0;
        for (var l in s) s[l] == t && (n = parseInt(l) + 1);
        o.currentNum = n, this.setData({
            blist: o
        });
    }
});
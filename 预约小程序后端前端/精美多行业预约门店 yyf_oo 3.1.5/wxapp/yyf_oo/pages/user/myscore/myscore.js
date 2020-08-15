var t = getApp();

Page({
    data: {
        list: {},
        isnull: 0,
        blist: {}
    },
    onLoad: function(t) {
        this.loadData(0), this.tabbar();
    },
    onPullDownRefresh: function() {
        wx.showNavigationBarLoading(), this.loadData(1);
    },
    loadData: function(a) {
        var r = this, o = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/Score",
            data: {
                m: "yyf_oo",
                uniacid: o
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || (r.setData({
                    list: t.data.data.list,
                    isnull: t.data.data.isnull
                }), a && (wx.stopPullDownRefresh(), wx.stopPullDownRefresh()));
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
        if (!(e = wx.getStorageSync("barlist"))) return !1;
        this.setData({
            blist: e,
            tcolor: e.tcolor,
            hide_tabbar: e.hide_tabbar,
            style: e.style
        });
        var a, r;
        a = "" != e.font_color ? e.font_color : "#ffffff", r = "" != e.head_color ? e.head_color : e.tcolor, 
        wx.setNavigationBarColor({
            frontColor: a,
            backgroundColor: r
        });
        var o = getCurrentPages(), i = o[o.length - 1], e = this.data.blist;
        i.options.tid == t && (e.isCurrentPage = !0);
        var s = new Array(e.m1_path, e.m2_path, e.m3_path, e.m4_path), n = 0;
        for (var l in s) s[l] == t && (n = parseInt(l) + 1);
        e.currentNum = n, this.setData({
            blist: e
        });
    }
});
var t = getApp();

Page({
    data: {
        list: {},
        isnull: 0,
        blist: {},
        position1: 0
    },
    onLoad: function(t) {
        console.log("11"), this.loadData(0), this.tabbar();
    },
    onPullDownRefresh: function() {
        wx.showNavigationBarLoading(), this.loadData(1);
    },
    loadData: function(a) {
        var o = this, i = t.siteInfo.uniacid;
        wx.getLocation({
            type: "wgs84",
            success: function(r) {
                t.util.request({
                    url: "entry/wxapp/index",
                    data: {
                        m: "yyf_oo",
                        uniacid: i,
                        op: "shopswitch",
                        position: r.latitude.toString() + "," + r.longitude.toString()
                    },
                    cachetime: 0,
                    success: function(t) {
                        t.data.errno || (o.setData({
                            list: t.data.data.list,
                            isnull: t.data.data.isnull
                        }), a && (wx.stopPullDownRefresh(), wx.stopPullDownRefresh()));
                    }
                });
            }
        });
    },
    shopSwitch: function(t) {
        var a = t.currentTarget.dataset.sid;
        wx.navigateTo({
            url: "../index?sid=" + a
        });
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
    setTabBar: function(t) {
        if (!(e = wx.getStorageSync("barlist"))) return !1;
        this.setData({
            blist: e,
            tcolor: e.tcolor,
            hide_tabbar: e.hide_tabbar,
            style: e.style
        });
        var a, o;
        a = "" != e.font_color ? e.font_color : "#ffffff", o = "" != e.head_color ? e.head_color : e.tcolor, 
        wx.setNavigationBarColor({
            frontColor: a,
            backgroundColor: o
        });
        var i = getCurrentPages(), r = i[i.length - 1], e = this.data.blist;
        r.options.tid == t && (e.isCurrentPage = !0);
        var n = new Array(e.m1_path, e.m2_path, e.m3_path, e.m4_path), s = 0;
        for (var l in n) n[l] == t && (s = parseInt(l) + 1);
        e.currentNum = s, this.setData({
            blist: e
        });
    }
});
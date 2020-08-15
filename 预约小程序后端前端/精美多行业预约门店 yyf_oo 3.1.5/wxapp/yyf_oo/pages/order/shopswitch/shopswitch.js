var t = getApp();

Page({
    data: {
        list: {},
        isnull: 0,
        blist: {},
        gid: 0,
        sid: 0
    },
    onLoad: function(t) {
        var a = t.gid, i = t.sid;
        this.setData({
            gid: a,
            sid: i
        }), this.loadData(0, a, i), this.tabbar();
    },
    onPullDownRefresh: function() {
        wx.showNavigationBarLoading(), this.loadData(1, this.data.gid, this.data.sid);
    },
    loadData: function(a, i, r) {
        var s = this, e = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/order",
            data: {
                m: "yyf_oo",
                uniacid: e,
                op: "shopswitch",
                gid: i,
                sid: r
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || (s.setData({
                    list: t.data.data.list,
                    isnull: t.data.data.isnull
                }), a && (wx.stopPullDownRefresh(), wx.stopPullDownRefresh()));
            }
        });
    },
    shopSwitch: function(t) {
        var a = t.currentTarget.dataset.sid, i = t.currentTarget.dataset.name, r = t.currentTarget.dataset.id;
        1 == this.data.list[r].status && wx.navigateTo({
            url: "../order?sid=" + a + "&name=" + i + "&id=" + this.data.gid
        });
    },
    tabbar: function() {
        var a = this, i = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/tabbar",
            data: {
                m: "yyf_oo",
                uniacid: i
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) {
                    var i = wx.getStorageSync("barlist");
                    "" != i && i.uptime == t.data.data.uptime || wx.setStorageSync("barlist", t.data.data), 
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
        var a, i;
        a = "" != e.font_color ? e.font_color : "#ffffff", i = "" != e.head_color ? e.head_color : e.tcolor, 
        wx.setNavigationBarColor({
            frontColor: a,
            backgroundColor: i
        });
        var r = getCurrentPages(), s = r[r.length - 1], e = this.data.blist;
        s.options.tid == t && (e.isCurrentPage = !0);
        var o = new Array(e.m1_path, e.m2_path, e.m3_path, e.m4_path), n = 0;
        for (var d in o) o[d] == t && (n = parseInt(d) + 1);
        e.currentNum = n, this.setData({
            blist: e
        });
    }
});
var t = getApp();

Page({
    data: {
        list: [],
        lastid: 0,
        tid: 0,
        catname: "",
        copyright: "",
        cats: [],
        currentTabsIndex: 0,
        fid: 0,
        currentCatId: 0,
        fatherId: 0,
        blist: {},
        tcolor: "",
        catkey: -1,
        hide_time: "0",
        hide_tabbar: "0",
        style: [],
        windowWidth: 0,
        hide_price: 0
    },
    onLoad: function(t) {
        this.getContent(t);
    },
    getContent: function(a) {
        var e = a.tid, i = a.fid;
        i || (i = 0), this.setData({
            tid: e,
            fid: i,
            currentCatId: e
        });
        var r, d = this;
        wx.getSystemInfo({
            success: function(t) {
                r = t.windowWidth, d.setData({
                    windowWidth: r
                });
            }
        }), this.loadData(0), this.setData({
            copyright: t.globalData.copyright
        }), this.setTabBar(e);
    },
    loadMore: function(t) {
        var a = t.currentTarget.dataset.lastid;
        this.loadData(a);
    },
    catClick: function(t) {
        var a = t.currentTarget.dataset.cid, e = t.currentTarget.dataset.fid, i = t.currentTarget.dataset.catkey;
        this.data.catkey != i && (this.setData({
            tid: a,
            fid: e,
            catkey: i,
            lastid: 0
        }), this.loadData(0));
    },
    loadData: function(a) {
        var e = this, i = t.siteInfo.uniacid, r = e.data.tid, d = e.data.fid, n = e.data.windowWidth;
        t.util.request({
            url: "entry/wxapp/news",
            data: {
                m: "yyf_oo",
                lastid: a,
                uniacid: i,
                tid: r,
                fid: d,
                windowWidth: n
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) {
                    e.setData({
                        catname: t.data.data.catname,
                        currentTabsIndex: t.data.data.currentIndex,
                        fatherId: t.data.data.fatherId,
                        hide_time: t.data.data.hide_time,
                        hide_price: t.data.data.hide_price
                    }), e.setData({
                        cats: t.data.data.cats
                    }), wx.setNavigationBarTitle({
                        title: t.data.data.catname
                    });
                    var a = t.data.data.list.length, i = t.data.data.currentCatId;
                    if (e.data.currentCatId != i ? (console.log(e.data.currentCatId + "---" + i), e.setData({
                        list: [],
                        currentCatId: i
                    })) : console.log(1111), a > 0) {
                        var r = e.data.lastid + 8;
                        e.setData({
                            lastid: r
                        });
                        var d = e.data.list.concat(t.data.data.list);
                        e.setData({
                            list: d
                        });
                    }
                }
            }
        }), t.util.request({
            url: "entry/wxapp/TabBar",
            data: {
                m: "yyf_oo",
                uniacid: i
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) {
                    var a = wx.getStorageSync("barlist");
                    "" != a && a.uptime == t.data.data.uptime || (wx.setStorageSync("barlist", t.data.data), 
                    e.setTabBar());
                }
            }
        });
    },
    onShareAppMessage: function(t) {
        return {
            title: this.data.catname,
            path: "/yyf_company/pages/news/news?tid=" + this.data.fatherId
        };
    },
    setTabBar: function(t) {
        if (!(d = wx.getStorageSync("barlist"))) return !1;
        this.setData({
            blist: d,
            tcolor: d.tcolor,
            hide_tabbar: d.hide_tabbar,
            style: d.style
        });
        var a, e;
        a = "" != d.font_color ? d.font_color : "#ffffff", e = "" != d.head_color ? d.head_color : d.tcolor, 
        wx.setNavigationBarColor({
            frontColor: a,
            backgroundColor: e
        });
        var i = getCurrentPages(), r = i[i.length - 1], d = this.data.blist;
        r.options.tid == t && (d.isCurrentPage = !0);
        var n = new Array(d.m1_path, d.m2_path, d.m3_path, d.m4_path), s = 0;
        for (var o in n) n[o] == t && (s = parseInt(o) + 1);
        d.currentNum = s, this.setData({
            blist: d
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
    }
});
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
        cattype: "0",
        catkey: -1,
        imgView_height: 147,
        thumb_height: "",
        hide_tabbar: "0",
        is_addHeight: 0,
        windowWidth: 0,
        style: [],
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
        var d;
        wx.getSystemInfo({
            success: function(t) {
                d = t.windowWidth;
            }
        }), this.setData({
            windowWidth: d
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
        var e = this, i = t.siteInfo.uniacid, d = e.data.tid, r = e.data.fid, s = e.data.windowWidth;
        t.util.request({
            url: "entry/wxapp/news",
            data: {
                m: "yyf_oo",
                lastid: a,
                uniacid: i,
                tid: d,
                fid: r,
                windowWidth: s
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) {
                    if (!e.data.is_addHeight) {
                        var a = parseInt(t.data.data.thumb_height), i = 0;
                        140 != a && (i = e.data.imgView_height + (a - 105), e.setData({
                            imgView_height: i,
                            is_addHeight: 1
                        }));
                    }
                    e.setData({
                        catname: t.data.data.catname,
                        currentTabsIndex: t.data.data.currentIndex,
                        fatherId: t.data.data.fatherId,
                        thumb_height: t.data.data.thumb_height,
                        hide_price: t.data.data.hide_price
                    }), e.setData({
                        cats: t.data.data.cats,
                        cattype: t.data.data.type
                    }), wx.setNavigationBarTitle({
                        title: t.data.data.catname
                    });
                    var d = t.data.data.list.length, r = t.data.data.currentCatId;
                    if (e.data.currentCatId != r && e.setData({
                        list: [],
                        currentCatId: r
                    }), d > 0) {
                        var s = e.data.lastid + 8;
                        e.setData({
                            lastid: s
                        });
                        var n = e.data.list.concat(t.data.data.list);
                        e.setData({
                            list: n
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
            path: "/yyf_company/pages/case/case?tid=" + this.data.fatherId
        };
    },
    setTabBar: function(t) {
        if (!(r = wx.getStorageSync("barlist"))) return !1;
        this.setData({
            blist: r,
            tcolor: r.tcolor,
            hide_tabbar: r.hide_tabbar,
            style: r.style
        });
        var a, e;
        a = "" != r.font_color ? r.font_color : "#ffffff", e = "" != r.head_color ? r.head_color : r.tcolor, 
        wx.setNavigationBarColor({
            frontColor: a,
            backgroundColor: e
        });
        var i = getCurrentPages(), d = i[i.length - 1], r = this.data.blist;
        d.options.tid == t && (r.isCurrentPage = !0);
        var s = new Array(r.m1_path, r.m2_path, r.m3_path, r.m4_path), n = 0;
        for (var o in s) s[o] == t && (n = parseInt(o) + 1);
        r.currentNum = n, this.setData({
            blist: r
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
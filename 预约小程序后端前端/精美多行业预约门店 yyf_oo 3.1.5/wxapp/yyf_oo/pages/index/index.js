var t = getApp();

Page({
    data: {
        slide: [],
        sysinfo: {},
        list: [],
        cats: [],
        copyright: "",
        blist: {},
        tcolor: "",
        head_color: "",
        couponList: [],
        personList: [],
        rankList: [],
        style: [],
        nav_height: "",
        couponTitle: [],
        personTitle: [],
        notice: "",
        multi: 0,
        shopname: "",
        sid: 0,
        shopinfo: []
    },
    onLoad: function(a) {
        var e = a.scene;
        console.log(e), void 0 != e && wx.navigateTo({
            url: "../details/details?scene=" + e
        });
        var n = this;
        void 0 == a.sid ? t.util.request({
            url: "entry/wxapp/index",
            data: {
                m: "yyf_oo",
                uniacid: t.siteInfo.uniacid,
                op: "judgeshop"
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) if ("2" == t.data.data) {
                    var a = wx.getStorageSync("sid");
                    if ("" != a && a) n.getContent(2, 0, a); else {
                        var e = wx.getStorageSync("position");
                        "" != e && e ? n.getContent(2, e) : wx.getLocation({
                            type: "wgs84",
                            success: function(t) {
                                wx.setStorageSync("position", t.latitude.toString() + "," + t.longitude.toString()), 
                                e = wx.getStorageSync("position"), n.getContent(2, e);
                            },
                            fail: function(t) {
                                n.getContent(2, 0);
                            }
                        });
                    }
                } else n.getContent(1, 0);
            }
        }) : n.getContent(2, 0, a.sid);
    },
    shopChoice: function() {
        var t = wx.getStorageSync("position");
        return !("" == t || !t) || (wx.getLocation({
            type: "wgs84",
            success: function(t) {
                wx.setStorageSync("position", t.latitude.toString() + "," + t.longitude.toString());
            },
            fail: function(t) {
                return !1;
            }
        }), !0);
    },
    getContent: function(a, e) {
        var n, i = arguments.length > 2 && void 0 !== arguments[2] ? arguments[2] : 0, o = this, s = t.siteInfo.uniacid;
        wx.getSystemInfo({
            success: function(t) {
                n = t.windowWidth;
            }
        }), t.util.request({
            url: "entry/wxapp/index",
            data: {
                m: "yyf_oo",
                uniacid: s,
                op: "slide"
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || o.setData({
                    slide: t.data.data
                });
            }
        }), t.util.request({
            url: "entry/wxapp/index",
            data: {
                m: "yyf_oo",
                uniacid: s,
                op: "content",
                windowwidth: n,
                multi: a,
                position: e,
                sid: i
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || (o.setData({
                    multi: a,
                    cats: t.data.data.cats,
                    list: t.data.data.list,
                    couponList: t.data.data.couponlist,
                    personList: t.data.data.personlist,
                    rankList: t.data.data.ranklist,
                    style: t.data.data.styledata,
                    nav_height: t.data.data.styledata.nav_height,
                    couponTitle: t.data.data.couponTitle,
                    personTitle: t.data.data.personTitle,
                    notice: t.data.data.notice,
                    shopname: t.data.data.shopname,
                    shopinfo: t.data.data.shopinfo
                }), "2" == a && wx.setStorageSync("sid", t.data.data.sid));
            }
        }), t.util.request({
            url: "entry/wxapp/tabbar",
            data: {
                m: "yyf_oo",
                uniacid: s
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) {
                    console.log(t.data.data);
                    var a = wx.getStorageSync("barlist");
                    "" != a && a.uptime == t.data.data.uptime || wx.setStorageSync("barlist", t.data.data), 
                    o.setTabBar();
                }
            }
        });
    },
    onShareAppMessage: function(t) {
        var a, e;
        return e = wx.getStorageSync("sid"), a = "" != e && e ? "/yyf_oo/pages/index/index?sid=" + e : "/yyf_oo/pages/index/index", 
        {
            title: this.data.sysinfo.name,
            path: a
        };
    },
    setTabBar: function() {
        if (!(i = wx.getStorageSync("barlist"))) return !1;
        this.setData({
            blist: i,
            tcolor: i.tcolor
        });
        var t, a;
        t = "" != i.font_color ? i.font_color : "#ffffff", a = "" != i.head_color ? i.head_color : i.tcolor, 
        wx.setNavigationBarColor({
            frontColor: t,
            backgroundColor: a
        }), wx.setNavigationBarTitle({
            title: i.name
        });
        var e = getCurrentPages(), n = e[e.length - 1].route, i = this.data.blist, o = n.split("/");
        "index" == o[o.length - 1] && (i.isCurrentPage = !0);
        var s = new Array(i.m1_path, i.m2_path, i.m3_path, i.m4_path), r = 0;
        for (var d in s) "index" == s[d] && (r = parseInt(d) + 1);
        i.currentNum = r, this.setData({
            blist: i
        });
    },
    tel: function() {
        var t = this.data.shopinfo.phone;
        wx.makePhoneCall({
            phoneNumber: t
        });
    },
    driver: function() {
        wx.openLocation({
            latitude: Number(this.data.shopinfo.jing),
            longitude: Number(this.data.shopinfo.wei),
            address: this.data.shopinfo.address
        });
    },
    playVideo: function(t) {
        var a = t.currentTarget.dataset.fidx, e = t.currentTarget.dataset.sidx, n = this.data.list;
        n[a].list[e].show_video = !0, this.setData({
            list: n
        });
    },
    navto: function(t) {
        var a = t.currentTarget.dataset.nid, e = this.data.cats[a].url;
        if (wx.setStorageSync("navurl", e), "-1" != e.indexOf("https")) e = "../webview/webview?op=nav" + this.data.cats[a].id;
        wx.navigateTo({
            url: e
        });
    },
    navPerson: function(t) {
        var a = t.currentTarget.dataset.pid;
        wx.navigateTo({
            url: "../persondetails/persondetails?id=" + a
        });
    },
    navShopSwitch: function() {
        wx.navigateTo({
            url: "shop/shop"
        });
    },
    ad1nav: function() {
        t = this.data.adsense.a1urlnew;
        if (wx.setStorageSync("navurl", t), "-1" != t.indexOf("https")) var t = "../webview/webview?op=ads1";
        wx.navigateTo({
            url: t
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
    notice1: function(t) {
        wx.showModal({
            title: "",
            content: t,
            success: function(t) {}
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
    receive_btn: function(a) {
        var e = this, n = t.siteInfo.uniacid, i = parseInt(a.currentTarget.dataset.cid);
        t.util.request({
            url: "entry/wxapp/coupon",
            data: {
                m: "yyf_oo",
                uniacid: n,
                op: "receive",
                id: i
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno ? wx.showToast({
                    title: t.data.message
                }) : (wx.showModal({
                    title: "领取成功",
                    content: "可以在会员中心里查看"
                }), e.setData({
                    list: t.data.data
                }), e.getContent());
            }
        });
    }
});
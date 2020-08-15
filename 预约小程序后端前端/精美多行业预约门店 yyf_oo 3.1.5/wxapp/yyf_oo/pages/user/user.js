var a = getApp();

Page({
    data: {
        userinfo: [],
        backimg: "",
        phone: 0,
        copyphone: 0,
        copyvalue: "",
        hidecopy: "0",
        score: 0,
        isadmin: 0,
        levelName: "",
        blist: {},
        coupon_num: 0,
        money: 0,
        close_pay: 0,
        shopjing: "",
        shopwei: "",
        shopphone: 0
    },
    onShow: function() {
        var t = this, e = a.siteInfo.uniacid, o = wx.getStorageSync("userInfo");
        this.setData({
            userinfo: o.wxInfo
        });
        var n = wx.getStorageSync("sid");
        a.util.request({
            url: "entry/wxapp/User",
            data: {
                m: "yyf_oo",
                uniacid: e,
                sid: n
            },
            cachetime: 0,
            success: function(a) {
                if (!a.data.errno && (t.setData({
                    backimg: a.data.data.backimg,
                    phone: a.data.data.tel,
                    score: a.data.data.score,
                    levelName: a.data.data.levelname,
                    coupon_num: a.data.data.coupon_num,
                    money: a.data.data.money,
                    close_pay: a.data.data.close_pay,
                    shopjing: a.data.data.shopjing,
                    shopwei: a.data.data.shopwei,
                    shopphone: a.data.data.shopphone
                }), void 0 == t.data.userinfo && "" != a.data.data.userinfo)) {
                    t.setData({
                        userinfo: a.data.data.userinfo
                    });
                    var e = wx.getStorageSync("userInfo");
                    e.wxInfo = a.data.data.userinfo, wx.setStorageSync("userInfo", e);
                }
            }
        }), a.util.request({
            url: "entry/wxapp/tabbar",
            data: {
                m: "yyf_oo",
                uniacid: e
            },
            cachetime: 0,
            success: function(a) {
                if (!a.data.errno) {
                    var e = wx.getStorageSync("barlist");
                    "" != e && e.uptime == a.data.data.uptime || wx.setStorageSync("barlist", a.data.data), 
                    t.setTabBar();
                }
            }
        });
    },
    updateUserInfo: function(a) {
        var t = getApp(), e = this, o = t.siteInfo.uniacid;
        t.util.getUserInfo(function(a) {
            t.util.request({
                url: "entry/wxapp/UpdateUser",
                data: {
                    m: "yyf_oo",
                    uniacid: o,
                    avatar: a.wxInfo.avatarUrl,
                    city: a.wxInfo.city,
                    gender: a.wxInfo.gender,
                    nickname: a.wxInfo.nickName
                },
                cachetime: 0,
                success: function(a) {
                    a.data.errno || e.setData({
                        userinfo: a.data.data
                    });
                }
            });
        }, a.detail);
    },
    tel: function() {
        var a = this.data.shopphone;
        wx.makePhoneCall({
            phoneNumber: a
        });
    },
    driver: function() {
        wx.openLocation({
            latitude: Number(this.data.shopjing),
            longitude: Number(this.data.shopwei),
            address: this.data.blist.address
        });
    },
    copyCalling: function() {
        this.data.copyphone && wx.makePhoneCall({
            phoneNumber: this.data.copyphone,
            success: function() {
                console.log("拨打电话成功！");
            },
            fail: function() {
                console.log("拨打电话失败！");
            }
        });
    },
    copy_action: function() {
        var a = this.data.blist.copyright;
        if ("1" == a.copy_kind) {
            var t = a.copy_phone;
            wx.makePhoneCall({
                phoneNumber: t
            });
        }
    },
    navOrder: function(a) {
        var t = a.currentTarget.dataset.status;
        wx.navigateTo({
            url: "../man/man?status=" + t
        });
    },
    nav: function(a) {
        var t = a.currentTarget.dataset.url;
        wx.navigateTo({
            url: t
        });
    },
    setTabBar: function() {
        if (!(n = wx.getStorageSync("barlist"))) return !1;
        this.setData({
            blist: n,
            tcolor: n.tcolor
        });
        var a, t;
        a = "" != n.font_color ? n.font_color : "#ffffff", t = "" != n.head_color ? n.head_color : n.tcolor, 
        wx.setNavigationBarColor({
            frontColor: a,
            backgroundColor: t
        }), wx.setNavigationBarTitle({
            title: n.name
        });
        var e = getCurrentPages(), o = e[e.length - 1].route, n = this.data.blist, r = o.split("/");
        "user" == r[r.length - 1] && (n.isCurrentPage = !0);
        var i = new Array(n.m1_path, n.m2_path, n.m3_path, n.m4_path), s = 0;
        for (var c in i) "user" == i[c] && (s = parseInt(c) + 1);
        n.currentNum = s, this.setData({
            blist: n
        });
    },
    tabNav: function(a) {
        var t = a.currentTarget.dataset.url, e = a.currentTarget.dataset.tab;
        if ("-1" != t.indexOf("https")) {
            wx.setStorageSync("navurl", t);
            t = "../webview/webview?op=" + e;
            wx.navigateTo({
                url: t
            });
        } else wx.navigateTo({
            url: t
        });
    }
});
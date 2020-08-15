var a = getApp();

Page({
    data: {
        phone: "1",
        username: "",
        backimg: "",
        levelList: {},
        levelName: ""
    },
    onShow: function() {
        var t = this, e = a.siteInfo.uniacid;
        this.tabbar(), a.util.request({
            url: "entry/wxapp/Userinfo",
            data: {
                m: "yyf_oo",
                uniacid: e
            },
            cachetime: 0,
            success: function(a) {
                a.data.errno || t.setData({
                    backimg: a.data.data.backimg,
                    phone: a.data.data.userData.phone,
                    username: a.data.data.userData.username,
                    levelList: a.data.data.leverData,
                    levelName: a.data.data.levelname
                });
            }
        });
    },
    usernameAction: function(a) {
        this.setData({
            username: a.detail.value
        });
    },
    phoneAction: function(a) {
        this.setData({
            phone: a.detail.value
        });
    },
    submitAction: function() {
        var t = this.data.phone, e = this.data.username;
        if ("" == t || "" == e) return wx.showModal({
            title: "",
            content: "姓名和手机号不能为空"
        }), !1;
        var r = a.siteInfo.uniacid;
        a.util.request({
            url: "entry/wxapp/Userinfo",
            data: {
                m: "yyf_oo",
                uniacid: r,
                phone: t,
                username: e,
                op: "edit"
            },
            cachetime: 0,
            success: function(a) {
                a.data.errno || wx.showModal({
                    title: "",
                    content: "修改成功"
                });
            }
        });
    },
    tabbar: function() {
        var t = this, e = a.siteInfo.uniacid;
        a.util.request({
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
    setTabBar: function(a) {
        if (!(n = wx.getStorageSync("barlist"))) return !1;
        this.setData({
            blist: n,
            tcolor: n.tcolor,
            hide_tabbar: n.hide_tabbar,
            style: n.style
        });
        var t, e;
        t = "" != n.font_color ? n.font_color : "#ffffff", e = "" != n.head_color ? n.head_color : n.tcolor, 
        wx.setNavigationBarColor({
            frontColor: t,
            backgroundColor: e
        });
        var r = getCurrentPages(), i = r[r.length - 1], n = this.data.blist;
        i.options.tid == a && (n.isCurrentPage = !0);
        var o = new Array(n.m1_path, n.m2_path, n.m3_path, n.m4_path), s = 0;
        for (var u in o) o[u] == a && (s = parseInt(u) + 1);
        n.currentNum = s, this.setData({
            blist: n
        });
    }
});
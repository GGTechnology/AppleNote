var t = getApp(), a = require("../../../wxParse/wxParse.js");

Page({
    data: {
        list: [],
        style: [],
        listItem: [],
        tcolor: "",
        hide_price: 0
    },
    onLoad: function(t) {
        console.log(t), this.getContent(t);
    },
    getContent: function(e) {
        var i, o = this, r = t.siteInfo.uniacid, n = e.id;
        wx.getSystemInfo({
            success: function(t) {
                i = t.windowWidth;
            }
        }), t.util.request({
            url: "entry/wxapp/person",
            data: {
                m: "yyf_oo",
                uniacid: r,
                id: n,
                op: "persondetails",
                windowWidth: i
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) {
                    var e = t.data.data.personarr, i = t.data.data.stylearr;
                    a.wxParse("article1", "html", e.desc, o, 10), o.setData({
                        list: e,
                        style: i,
                        listItem: t.data.data.listitem,
                        hide_price: t.data.data.hide_price
                    }), wx.setNavigationBarTitle({
                        title: e.name
                    });
                    var r, n;
                    r = "" != i.font_color ? i.font_color : "#ffffff", n = "" != i.head_color ? i.head_color : i.tcolor, 
                    wx.setNavigationBarColor({
                        frontColor: r,
                        backgroundColor: n
                    });
                }
            }
        });
    },
    onShareAppMessage: function() {},
    navPersonComment: function() {
        var t = this.data.list.id, a = this.data.list.name;
        wx.navigateTo({
            url: "./personcomment?id=" + t + "&name=" + a
        });
    },
    submitOrder: function() {
        var t = this.data.list.id;
        wx.navigateTo({
            url: "../order/order?id=" + t
        });
    }
});
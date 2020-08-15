function t(t, a, e) {
    return a in t ? Object.defineProperty(t, a, {
        value: e,
        enumerable: !0,
        configurable: !0,
        writable: !0
    }) : t[a] = e, t;
}

var a, e = getApp(), i = require("../../../wxParse/wxParse.js");

Page({
    data: (a = {
        list: [],
        style: [],
        commentList: [],
        tcolor: "",
        stars: [ 0, 1, 2, 3, 4 ],
        normalSrc: "../../resource/images/no-star.png",
        selectedSrc: "../../resource/images/full-star.png",
        halfSrc: "../../resource/images/half-star.png",
        key: 3
    }, t(a, "list", {}), t(a, "hide_price", 0), t(a, "shopjing", ""), t(a, "shopwei", ""), 
    t(a, "shopphone", 0), t(a, "address", ""), t(a, "orderCode", ""), a),
    onLoad: function(t) {
        var a = t.scene;
        if (void 0 != a) {
            var e = a.split("-");
            t.id = e[0], wx.setStorageSync("sid", e[1]);
        }
        this.getContent(t), this.getComment(t);
    },
    getContent: function(t) {
        var a = this, o = e.siteInfo.uniacid, s = t.id, n = wx.getStorageSync("sid");
        e.util.request({
            url: "entry/wxapp/details",
            data: {
                m: "yyf_oo",
                uniacid: o,
                id: s,
                sid: n
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) {
                    var e = t.data.data.itemarr, o = t.data.data.stylearr;
                    i.wxParse("article1", "html", e.content, a, 10), a.setData({
                        list: e,
                        style: o,
                        hide_price: t.data.data.hide_price,
                        shopjing: t.data.data.shopjing,
                        shopwei: t.data.data.shopwei,
                        shopphone: t.data.data.shopphone,
                        address: t.data.data.address
                    }), wx.setNavigationBarTitle({
                        title: e.title
                    });
                    var s, n;
                    s = "" != o.font_color ? o.font_color : "#ffffff", n = "" != o.head_color ? o.head_color : o.tcolor, 
                    wx.setNavigationBarColor({
                        frontColor: s,
                        backgroundColor: n
                    });
                }
            }
        });
    },
    getComment: function(t) {
        var a = this, i = e.siteInfo.uniacid, o = t.id;
        e.util.request({
            url: "entry/wxapp/Comment",
            data: {
                m: "yyf_oo",
                uniacid: i,
                id: o,
                op: "list"
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || a.setData({
                    commentList: t.data.data
                });
            }
        });
    },
    tel: function() {
        var t = this.data.shopphone;
        wx.makePhoneCall({
            phoneNumber: t
        });
    },
    driver: function() {
        wx.openLocation({
            latitude: Number(this.data.shopjing),
            longitude: Number(this.data.shopwei),
            address: this.data.address
        });
    },
    onShareAppMessage: function() {},
    submitOrder: function(t) {
        var a = this.data.list.id, e = t.currentTarget.dataset.startgroup;
        wx.navigateTo({
            url: "../order/order?id=" + a + "&startgroup=" + e
        });
    },
    navIndexAction: function() {
        wx.navigateTo({
            url: "../index/index"
        });
    },
    creatBill: function() {
        var t = this.data, a = this;
        e.util.request({
            url: "entry/wxapp/CreatBill",
            data: {
                m: "yyf_oo",
                uniacid: e.siteInfo.uniacid,
                sid: wx.getStorageSync("sid"),
                id: t.list.id
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno ? a.notice(t.data.message) : (console.log(t), a.setData({
                    isShow: !0,
                    orderCode: t.data.data
                }));
            }
        });
    },
    closeRoom: function() {
        this.setData({
            isShow: !1
        });
    },
    notice: function(t) {
        wx.showModal({
            title: t,
            content: "",
            success: function(t) {}
        });
    },
    saveImgAction: function() {
        var t = this;
        wx.getImageInfo({
            src: this.data.orderCode,
            success: function(a) {
                wx.saveImageToPhotosAlbum({
                    filePath: a.path,
                    success: function(a) {
                        t.notice("保存成功"), t.setData({
                            isShow: !1
                        });
                    }
                });
            },
            fail: function(a) {
                t.notice("保存失败，请检查小程序官方后台配置");
            }
        });
    }
});
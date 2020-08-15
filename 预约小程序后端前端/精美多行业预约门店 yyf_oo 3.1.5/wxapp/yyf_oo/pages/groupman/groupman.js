var t = getApp();

Page({
    data: {
        list: {},
        currentTabsIndex: 10,
        currentCatId: 0,
        orderCode: "",
        isShow: !1,
        status: 0,
        style: [],
        hide_price: 0,
        multi: 1
    },
    catClick: function(t) {
        var a = t.currentTarget.dataset.sid;
        this.setData({
            currentTabsIndex: a
        }), this.loadData(a);
    },
    onLoad: function(a) {
        t.siteInfo.uniacid;
        console.log(e);
        var e = a.status;
        void 0 == e && (e = 10), this.setData({
            status: e,
            currentTabsIndex: e
        }), this.loadData(e);
    },
    loadData: function(a) {
        var e = this, i = t.siteInfo.uniacid;
        t.util.footer(e), t.util.request({
            url: "entry/wxapp/GroupOrder",
            data: {
                m: "yyf_oo",
                uniacid: i,
                status: a,
                op: "list"
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || (e.setData({
                    list: t.data.data.list,
                    style: t.data.data.stylearr,
                    hide_price: t.data.data.hide_price,
                    multi: t.data.data.multi
                }), e.handleStyle(t.data.data.stylearr));
            }
        });
    },
    buttonClick: function(a) {
        var e = a.currentTarget.dataset.id, i = a.currentTarget.dataset.sid, n = t.siteInfo.uniacid, o = this.data.list[e], s = o.oid, r = this;
        if ("pay" == i && t.util.request({
            url: "entry/wxapp/pay",
            data: {
                m: "yyf_oo",
                uniacid: n,
                price: o.total,
                ordersn: o.oid,
                title: o.ititle
            },
            header: {
                "content-type": "application/json"
            },
            success: function(t) {
                var a = t.data.data.package.split("=")[1];
                wx.requestPayment({
                    timeStamp: t.data.data.timeStamp,
                    nonceStr: t.data.data.nonceStr,
                    package: t.data.data.package,
                    signType: "MD5",
                    paySign: t.data.data.paySign,
                    success: function(t) {
                        r.sendMessage(a, o.oid);
                    },
                    fail: function(t) {}
                });
            },
            fail: function(t) {
                r.notice("微信支付失败！");
            }
        }), "cancel" == i) {
            var c = r.data.status;
            wx.showModal({
                title: "确认要取消订单么？",
                content: "",
                success: function(a) {
                    if (!a.confirm) return !1;
                    var e = t.siteInfo.uniacid;
                    t.util.request({
                        url: "entry/wxapp/Myorder",
                        data: {
                            m: "yyf_oo",
                            uniacid: e,
                            status: c,
                            oid: s,
                            op: "cancel"
                        },
                        cachetime: 0,
                        success: function(t) {
                            t.data.errno || r.loadData(c);
                        }
                    });
                }
            });
        }
    },
    sendMessage: function(a, e) {
        var i = t.siteInfo.uniacid, n = this;
        t.util.request({
            url: "entry/wxapp/SendMessage",
            data: {
                m: "yyf_oo",
                uniacid: i,
                pack: a,
                ordersn: e
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || (wx.showToast({
                    title: "支付成功",
                    icon: "success",
                    duration: 1e3
                }), n.loadData(10));
            }
        });
    },
    navGroup: function(t) {
        var a = t.currentTarget.dataset.id, e = this.data.list;
        "0" != e[a].group_status || "1" != e[a].status && "2" != e[a].status || "1" == e[a].overtime_status || wx.navigateTo({
            url: "../group/group?gid=" + e[a].gid + "&id=" + e[a].id
        });
    },
    navComment: function(t) {
        var a = t.currentTarget.dataset.oid;
        console.log(a), wx.navigateTo({
            url: "../comment/comment?oid=" + a
        });
    },
    notice: function(t) {
        wx.showModal({
            title: t,
            content: "",
            success: function(t) {}
        });
    },
    handleStyle: function(t) {
        var a, e;
        a = "" != t.font_color ? t.font_color : "#ffffff", e = "" != t.head_color ? t.head_color : t.tcolor, 
        wx.setNavigationBarColor({
            frontColor: a,
            backgroundColor: e
        });
    }
});
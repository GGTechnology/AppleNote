var a = getApp();

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
        multi: 1,
        start_arrange: 0,
        person_name: "",
        show_person: 0
    },
    catClick: function(a) {
        var t = a.currentTarget.dataset.sid;
        this.setData({
            currentTabsIndex: t
        }), this.loadData(t);
    },
    onLoad: function(t) {
        a.siteInfo.uniacid;
        console.log(e);
        var e = t.status;
        void 0 == e && (e = 10), this.setData({
            status: e,
            currentTabsIndex: e
        }), this.loadData(e);
    },
    loadData: function(t) {
        var e = this, n = a.siteInfo.uniacid;
        a.util.footer(e), a.util.request({
            url: "entry/wxapp/MyOrder",
            data: {
                m: "yyf_oo",
                uniacid: n,
                status: t,
                op: "list"
            },
            cachetime: 0,
            success: function(a) {
                a.data.errno || (e.setData({
                    list: a.data.data.list,
                    style: a.data.data.stylearr,
                    hide_price: a.data.data.hide_price,
                    multi: a.data.data.multi,
                    start_arrange: a.data.data.start_arrange,
                    person_name: a.data.data.person_name,
                    show_person: a.data.data.show_person
                }), e.handleStyle(a.data.data.stylearr));
            }
        });
    },
    buttonClick: function(t) {
        var e = t.currentTarget.dataset.id, n = t.currentTarget.dataset.sid, o = a.siteInfo.uniacid, i = this.data.list[e], s = i.oid, r = this;
        if ("pay" == n && a.util.request({
            url: "entry/wxapp/pay",
            data: {
                m: "yyf_oo",
                uniacid: o,
                price: i.total,
                ordersn: i.oid,
                title: i.ititle
            },
            header: {
                "content-type": "application/json"
            },
            success: function(a) {
                var t = a.data.data.package.split("=")[1];
                wx.requestPayment({
                    timeStamp: a.data.data.timeStamp,
                    nonceStr: a.data.data.nonceStr,
                    package: a.data.data.package,
                    signType: "MD5",
                    paySign: a.data.data.paySign,
                    success: function(a) {
                        r.sendMessage(t, i.oid);
                    },
                    fail: function(a) {}
                });
            },
            fail: function(a) {
                r.notice("微信支付失败！");
            }
        }), "cancel" == n) {
            var d = r.data.status;
            wx.showModal({
                title: "确认要取消订单么？",
                content: "",
                success: function(t) {
                    if (!t.confirm) return !1;
                    var e = a.siteInfo.uniacid;
                    a.util.request({
                        url: "entry/wxapp/Myorder",
                        data: {
                            m: "yyf_oo",
                            uniacid: e,
                            status: d,
                            oid: s,
                            op: "cancel"
                        },
                        cachetime: 0,
                        success: function(a) {
                            a.data.errno || r.loadData(d);
                        }
                    });
                }
            });
        }
    },
    sendMessage: function(t, e) {
        var n = a.siteInfo.uniacid, o = this;
        a.util.request({
            url: "entry/wxapp/SendMessage",
            data: {
                m: "yyf_oo",
                uniacid: n,
                pack: t,
                ordersn: e
            },
            cachetime: 0,
            success: function(a) {
                a.data.errno || (wx.showToast({
                    title: "支付成功",
                    icon: "success",
                    duration: 1e3
                }), o.loadData(10));
            }
        });
    },
    navComment: function(a) {
        var t = a.currentTarget.dataset.oid, e = a.currentTarget.dataset.kind, n = this.data.person_name;
        wx.navigateTo({
            url: "../comment/comment?oid=" + t + "&kind=" + e + "&person_name=" + n
        });
    },
    notice: function(a) {
        wx.showModal({
            title: a,
            content: "",
            success: function(a) {}
        });
    },
    handleStyle: function(a) {
        var t, e;
        t = "" != a.font_color ? a.font_color : "#ffffff", e = "" != a.head_color ? a.head_color : a.tcolor, 
        wx.setNavigationBarColor({
            frontColor: t,
            backgroundColor: e
        });
    }
});
function a(a, t, e) {
    return t in a ? Object.defineProperty(a, t, {
        value: e,
        enumerable: !0,
        configurable: !0,
        writable: !0
    }) : a[t] = e, a;
}

var t, e = getApp(), r = require("../../resource/js/dateTimePicker.js");

Page({
    data: (t = {
        list: [],
        style: [],
        formList: [],
        checkboxArr: {},
        useCouponTotal: 0,
        coupon: [],
        total: 0
    }, a(t, "coupon", []), a(t, "personName", "系统指定"), a(t, "pid", 0), a(t, "username", ""), 
    a(t, "phone", ""), a(t, "sale", ""), a(t, "is_arrival", 0), a(t, "arrival", 0), 
    a(t, "reminder", ""), a(t, "show_person", 0), a(t, "balance", 0), a(t, "hide_balance", 0), 
    a(t, "check_balance", 0), a(t, "person_name", ""), a(t, "close_pay", 0), a(t, "hide_price", 0), 
    a(t, "multi", 0), a(t, "sid", 0), a(t, "shopname", ""), a(t, "orderdate", 0), a(t, "orderstart", 0), 
    a(t, "dateTimeArray1", null), a(t, "dateTime1", null), a(t, "startYear", 2019), 
    a(t, "endYear", 2019), a(t, "currentDate", ""), a(t, "startgroup", 0), a(t, "gid", 0), 
    a(t, "start_arrange", 0), a(t, "start_mustpeo", 0), t),
    onLoad: function(a) {
        var t;
        t = void 0 === a.startgroup ? 0 : a.startgroup;
        var i;
        i = void 0 === a.gid ? 0 : a.gid, this.setData({
            gid: i
        });
        r.dateTimePicker(this.data.startYear, this.data.endYear);
        var s = r.dateTimePicker(this.data.startYear, this.data.endYear);
        s.dateTimeArray.pop(), s.dateTime.pop();
        this.setData({
            dateTimeArray1: s.dateTimeArray,
            dateTime1: s.dateTime,
            startgroup: t
        });
        var n = this, o = e.siteInfo.uniacid, d = a.id;
        if (void 0 != a.personname && a.pid && this.setData({
            personName: a.personname,
            pid: a.pid,
            gid: i
        }), "" != (c = wx.getStorageSync("sid")) && c || (c = 0), void 0 != a.sid && a.sid) {
            var c = a.sid;
            this.setData({
                sid: a.sid,
                shopname: a.name
            }), wx.setStorageSync("sid", a.sid);
        }
        e.util.request({
            url: "entry/wxapp/order",
            data: {
                m: "yyf_oo",
                uniacid: o,
                id: d,
                sid: c,
                startgroup: t,
                gid: i
            },
            cachetime: 0,
            success: function(a) {
                if (!a.data.errno) {
                    var t = a.data.data.stylearr;
                    n.setData({
                        style: t,
                        list: a.data.data.itemarr,
                        formList: a.data.data.formlist,
                        total: a.data.data.itemarr.price,
                        old_total: a.data.data.itemarr.price,
                        sale: a.data.data.sale,
                        is_arrival: a.data.data.is_arrival,
                        reminder: a.data.data.reminder,
                        show_person: a.data.data.show_person,
                        balance: a.data.data.balance,
                        person_name: a.data.data.person_name,
                        close_pay: a.data.data.close_pay,
                        hide_price: a.data.data.hide_price,
                        shopname: a.data.data.shopname,
                        sid: a.data.data.sid,
                        multi: a.data.data.multi,
                        start_arrange: a.data.data.start_arrange,
                        start_mustpeo: a.data.data.start_mustpeo
                    });
                    var e = a.data.data.userdata.username, r = a.data.data.userdata.phone;
                    "" != e && n.setData({
                        username: e
                    }), "" != r && n.setData({
                        phone: r
                    }), n.handleStyle(t), n.data.start_mustpeo && n.setData({
                        personName: "请选择" + n.data.person_name
                    });
                }
            }
        });
        var l = this.data.dateTimeArray1;
        console.log(l);
        var u = this.data.dateTime1, h = l[0][u[0]] + "-" + l[1][u[1]] + "-" + l[2][u[2]] + " " + l[3][u[3]] + ":" + l[4][u[4]];
        this.setData({
            currentDate: h
        });
    },
    submitOrder: function() {
        var a = this.data;
        "1" == a.close_pay && (a.arrival = 1);
        var t = a.username, r = a.phone, i = this;
        if ("" == t) return this.notice("姓名必须填写"), !1;
        var s = this.checkPhone(r);
        if ("1" != s) return this.notice(s), !1;
        if (!a.pid && "1" == a.start_mustpeo) {
            n = "必须选择" + this.data.person_name;
            return this.notice(n), !1;
        }
        if ("1" == a.start_arrange && !a.orderdate) {
            var n = "必须选择预约时间";
            return this.notice(n), !1;
        }
        var o;
        o = void 0 === a.coupon.id ? "0" : a.coupon.id;
        var d = e.siteInfo.uniacid;
        e.util.request({
            url: "entry/wxapp/order",
            data: {
                m: "yyf_oo",
                uniacid: d,
                op: "add",
                username: t,
                phone: r,
                cometime: a.currentDate,
                total: a.total,
                cid: o,
                couponmoney: a.useCouponTotal,
                arrival: a.arrival,
                score: a.list.score,
                sale: a.sale,
                diystr: a.checkboxArr,
                pid: a.pid,
                pname: a.personName,
                iid: a.list.id,
                ititle: a.list.title,
                price: a.list.price,
                check_balance: a.check_balance,
                sid: a.sid,
                startgroup: a.startgroup,
                gid: a.gid,
                orderdate: a.orderdate,
                orderstart: a.orderstart,
                currentDate: a.currentDate
            },
            cachetime: 0,
            success: function(t) {
                if ("999" == t.data) return wx.showModal({
                    title: "该优惠券已经使用，请到会员中心我的订单里支付。再次下单将会按原价支付",
                    content: "",
                    success: function(a) {
                        var t = parseFloat(i.data.total) + i.data.useCouponTotal;
                        i.setData({
                            cid: "0",
                            coupon: {},
                            total: t,
                            useCouponTotal: 0
                        });
                    }
                }), !1;
                if (!t.data.errno) {
                    var r = t.data.data.gid, s = t.data.data.orderid;
                    if ("0" != t.data.data.arrival) wx.showModal({
                        title: "预订成功",
                        content: "预订成功",
                        success: function(a) {
                            wx.navigateTo({
                                url: "../man/man"
                            });
                        }
                    }); else if ("1" == t.data.data.check_balance) i.setData({
                        orderdate: 0,
                        orderstart: 0,
                        pid: 0
                    }), wx.showModal({
                        title: "支付成功",
                        content: "支付成功",
                        success: function(a) {
                            "0" != r ? wx.navigateTo({
                                url: "../group/group?gid=" + r + "&id=" + s
                            }) : wx.navigateTo({
                                url: "../man/man"
                            });
                        }
                    }); else {
                        var n = t.data.data.ordersn, o = i.data.list.title;
                        e.util.request({
                            url: "entry/wxapp/pay",
                            data: {
                                m: "yyf_oo",
                                uniacid: d,
                                price: a.total,
                                ordersn: n,
                                title: o
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
                                        i.sendMessage(t, n, i.data.sid, r, s);
                                    },
                                    fail: function(a) {}
                                });
                            }
                        });
                    }
                }
            }
        });
    },
    sendMessage: function(a, t, r, i, s) {
        var n = e.siteInfo.uniacid;
        e.util.request({
            url: "entry/wxapp/SendMessage",
            data: {
                m: "yyf_oo",
                uniacid: n,
                pack: a,
                ordersn: t,
                sid: r
            },
            cachetime: 0,
            success: function(a) {
                a.data.errno || (wx.showToast({
                    title: "支付成功",
                    icon: "success",
                    duration: 1e3
                }), "0" != i ? wx.navigateTo({
                    url: "../group/group?gid=" + i + "&id=" + s
                }) : wx.navigateTo({
                    url: "../man/man"
                }));
            }
        });
    },
    checkboxChange: function(a) {
        var t = this.data.checkboxArr, e = a.currentTarget.dataset.key, r = a.detail.value, i = a.currentTarget.dataset.kind, s = a.currentTarget.dataset.fidx;
        if ("select" == i) {
            t[e] = this.data.formList[s].value[r];
            var n = this.data.formList;
            n[s].selectIndex = r, this.setData({
                formList: n
            });
        } else t[e] = r;
        this.setData({
            checkboxArr: t
        });
    },
    arrivalChange: function(a) {
        var t = 0;
        if (a.detail.value) {
            t = 1;
            e = 1;
        } else var e = 0;
        this.setData({
            arrival: t,
            hide_balance: e,
            check_balance: 0
        });
    },
    balanceChange: function(a) {
        var t = parseFloat(this.data.balance), e = this.data.check_balance;
        if (0 == t) return this.notice("没有余额哦！"), this.setData({
            check_balance: 0
        }), !1;
        a.detail.value ? (e = !0, this.setData({
            check_balance: e
        }), e && t < parseFloat(this.data.total) && (this.notice("余额不足，请先充值或者使用在线支付"), this.setData({
            check_balance: 0
        }))) : (e = !1, this.setData({
            check_balance: e
        }));
    },
    navShopSwitch: function() {
        var a = this.data.list.id, t = this.data.sid;
        wx.navigateTo({
            url: "shopswitch/shopswitch?gid=" + a + "&sid=" + t
        });
    },
    usernameChange: function(a) {
        this.setData({
            username: a.detail.value
        });
    },
    phoneChange: function(a) {
        this.setData({
            phone: a.detail.value
        });
    },
    checkPhone: function(a) {
        return 0 == a.length ? "请输入手机号码！" : 11 != a.length ? "请输入有效的手机号码！" : /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[0-9]{1})|(17[0-9]{1}))+\d{8})$/.test(a) ? "1" : "请输入有效的手机号码！";
    },
    notice: function(a) {
        wx.showModal({
            title: a,
            content: "",
            success: function(a) {}
        });
    },
    navCoupon: function() {
        if ("1" == this.data.startgroup) return this.notice("拼团活动不支持叠加优惠"), !1;
        var a = this.data.list.price;
        wx.navigateTo({
            url: "ordercoupon/ordercoupon?total=" + a
        });
    },
    navPerson: function() {
        var a = this.data.list.id;
        wx.navigateTo({
            url: "orderperson/orderperson?iid=" + a
        });
    },
    handleStyle: function(a) {
        var t, e;
        t = "" != a.font_color ? a.font_color : "#ffffff", e = "" != a.head_color ? a.head_color : a.tcolor, 
        wx.setNavigationBarColor({
            frontColor: t,
            backgroundColor: e
        });
    },
    changeDateTime1: function(a) {
        this.setData({
            dateTime1: a.detail.value
        });
    },
    changeDateTimeColumn1: function(a) {
        var t = this.data.dateTime1, e = this.data.dateTimeArray1;
        t[a.detail.column] = a.detail.value, e[2] = r.getMonthDay(e[0][t[0]], e[1][t[1]]), 
        this.setData({
            dateTimeArray1: e
        });
        var i = e, s = this.data.dateTime1, n = i[0][s[0]] + "-" + i[1][s[1]] + "-" + i[2][s[2]] + " " + i[3][s[3]] + ":" + i[4][s[4]];
        this.setData({
            currentDate: n
        });
    }
});
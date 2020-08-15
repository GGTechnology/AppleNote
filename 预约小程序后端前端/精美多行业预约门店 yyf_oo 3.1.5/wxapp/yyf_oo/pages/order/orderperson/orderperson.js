var t = getApp();

Page({
    data: {
        list: {},
        isnull: 0,
        showModalStatus: !1,
        calendar: [],
        width: 0,
        currentIndex: 0,
        currentTime: 0,
        timeArr: [],
        pid: 0,
        pname: "",
        iid: 0,
        start_arrange: 0
    },
    onLoad: function(a) {
        this.handleStyle();
        var e = this, i = t.siteInfo.uniacid, n = a.iid;
        this.setData({
            iid: n
        }), t.util.request({
            url: "entry/wxapp/person",
            data: {
                m: "yyf_oo",
                uniacid: i,
                op: "itempersonlist",
                iid: n,
                sid: wx.getStorageSync("sid")
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || e.setData({
                    list: t.data.data.list,
                    start_arrange: t.data.data.start_arrange
                });
            }
        });
    },
    loadData: function(a, e) {
        var i = this;
        t.util.request({
            url: "entry/wxapp/orderTime",
            data: {
                m: "yyf_oo",
                uniacid: t.siteInfo.uniacid,
                op: "index",
                dateday: a,
                iid: i.data.iid,
                id: e
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || i.setData({
                    timeArr: t.data.data
                });
            }
        });
    },
    submitTimeAction: function() {
        var t = this.data.timeArr, a = this.data.currentTime;
        if ("已过时" == t[a].status) return this.notice("已过时间，请选择其他时间"), !1;
        if ("已约满" == t[a].status || "不可约" == t[a].status) return this.notice("已约满，请选择其他时间"), 
        !1;
        var e = this.data.calendar[this.data.currentIndex].date, i = t[a].time, n = getCurrentPages();
        n[n.length - 2].setData({
            pid: this.data.pid,
            personName: this.data.pname,
            orderdate: e,
            orderstart: i
        }), wx.navigateBack({
            delta: 1
        });
    },
    creatWeekDays: function() {
        for (var t = this, a = new Date(), e = a.getFullYear(), i = a.getMonth() + 1, n = a.getDate(), r = [ "日", "一", "二", "三", "四", "五", "六" ], s = function(t, a) {
            return new Date(t, a, 0).getDate();
        }(e, i), d = function(t, a) {
            return new Date(Date.UTC(t, a - 1, 1)).getDay();
        }(e, i), o = 1; o <= s; o++) d > 6 && (d = 0), t.data.calendar[o] = new function(t, a) {
            this.date = e + "-" + i + "-" + t, this.week = t == n ? "今天" : t == n + 1 ? "明天" : "星期" + a;
        }(o, [ r[d] ][0]), d++;
        var c = t.data.calendar.splice(n, t.data.calendar.length - n <= 7 ? t.data.calendar.length : 7);
        console.log(c.length);
        var l = c.length;
        if (l < 7) for (var u = a.getMonth() + 2, h = 1, g = [ "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" ], o = l; o < 6; o++) {
            var f = e + "-" + u + "-" + h, D = new Date(Date.parse(e + "/" + u + "/" + h));
            D = g[D.getDay()], c[o] = {
                date: f,
                week: D
            }, h++;
        }
        console.log(c), t.setData({
            calendar: c
        }), t.setData({
            width: 186 * parseInt(t.data.calendar.length - n <= 7 ? t.data.calendar.length : 7)
        });
    },
    select: function(t) {
        this.setData({
            currentIndex: t.currentTarget.dataset.index
        }), this.loadData(this.data.calendar[t.currentTarget.dataset.index].date, this.data.pid);
    },
    selectTime: function(t) {
        this.setData({
            currentTime: t.currentTarget.dataset.tindex
        });
    },
    clickOrder: function(t) {
        var a = t.currentTarget.dataset.id, e = this.data.list[a].id;
        if ("1" == this.data.start_arrange && "0" != this.data.list[a].aid) {
            this.creatWeekDays();
            var i = t.currentTarget.dataset.statu;
            this.util(i), this.loadData(this.data.calendar[0].date, e);
            var a = t.currentTarget.dataset.id, n = this.data.list[a].name;
            this.setData({
                pid: e,
                pname: n
            });
        } else {
            var n = this.data.list[a].name, r = getCurrentPages();
            r[r.length - 2].setData({
                pid: e,
                personName: n
            }), wx.navigateBack({
                delta: 1
            });
        }
    },
    powerDrawer: function(t) {
        var a = t.currentTarget.dataset.statu;
        this.util(a);
    },
    handleStyle: function() {
        var t, a, e = getCurrentPages(), i = e[e.length - 2].data.style;
        t = "" != i.font_color ? i.font_color : "#ffffff", a = "" != i.head_color ? i.head_color : i.tcolor, 
        wx.setNavigationBarColor({
            frontColor: t,
            backgroundColor: a
        });
    },
    util: function(t) {
        var a = wx.createAnimation({
            duration: 200,
            timingFunction: "linear",
            delay: 0
        });
        this.animation = a, a.translateY(240).step(), this.setData({
            animationData: a.export()
        }), setTimeout(function() {
            a.translateY(0).step(), this.setData({
                animationData: a
            }), "close" == t && this.setData({
                showModalStatus: !1
            });
        }.bind(this), 200), "open" == t && this.setData({
            showModalStatus: !0
        });
    },
    notice: function(t) {
        wx.showModal({
            title: "提示",
            content: t,
            success: function(t) {}
        });
    }
});
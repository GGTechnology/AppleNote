var a = getApp();

Page({
    data: {
        calendar: [],
        width: 0,
        currentIndex: 0,
        currentTime: 0,
        timeArr: []
    },
    onLoad: function(a) {
        this.creatWeekDays();
    },
    loadData: function(t) {
        var e = this;
        a.util.request({
            url: "entry/wxapp/orderTime",
            data: {
                m: "yyf_oo",
                uniacid: a.siteInfo.uniacid,
                op: "index",
                dateday: t
            },
            cachetime: 0,
            success: function(a) {
                a.data.errno || e.setData({
                    timeArr: a.data.data
                });
            }
        });
    },
    creatWeekDays: function() {
        for (var a = this, t = new Date(), e = t.getFullYear(), n = t.getMonth() + 1, r = t.getDate(), d = [ "日", "一", "二", "三", "四", "五", "六" ], i = function(a, t) {
            return new Date(a, t, 0).getDate();
        }(e, n), c = function(a, t) {
            return new Date(Date.UTC(a, t - 1, 1)).getDay();
        }(e, n), s = 1; s <= i; s++) c > 6 && (c = 0), a.data.calendar[s] = new function(a, t) {
            this.date = e + "-" + n + "-" + a, this.week = a == r ? "今天" : a == r + 1 ? "明天" : "星期" + t;
        }(s, [ d[c] ][0]), c++;
        var u = a.data.calendar.splice(r, a.data.calendar.length - r <= 7 ? a.data.calendar.length : 7);
        a.setData({
            calendar: u
        }), a.setData({
            width: 186 * parseInt(a.data.calendar.length - r <= 7 ? a.data.calendar.length : 7)
        }), a.loadData(this.data.calendar[0].date);
    },
    select: function(a) {
        this.setData({
            currentIndex: a.currentTarget.dataset.index
        }), this.loadData(this.data.calendar[a.currentTarget.dataset.index].date);
    },
    selectTime: function(a) {
        this.setData({
            currentTime: a.currentTarget.dataset.tindex
        });
    }
});
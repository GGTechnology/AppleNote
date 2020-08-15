var t = getApp();

Page({
    data: {
        list: [],
        group: [],
        style: [],
        countDownDay: 0,
        countDownHour: 0,
        countDownMinute: 0,
        countDownSecond: 0,
        thumblist: [],
        lakeavatrtlist: [],
        gid: 0,
        existuser: !1,
        overtime: 0
    },
    onLoad: function(t) {
        var a, o = t.id;
        a = void 0 === t.gid ? 0 : t.gid, this.setData({
            gid: a
        }), this.getContent(o, a);
    },
    getContent: function(a, o) {
        var n = this, e = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/group",
            data: {
                m: "yyf_oo",
                uniacid: e,
                gid: o,
                id: a
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || (console.log(t.data.data), n.setData({
                    group: t.data.data.group,
                    list: t.data.data.data,
                    thumblist: t.data.data.thumblist,
                    lakeavatrtlist: t.data.data.lakeavatrtlist,
                    existuser: t.data.data.existuser
                }), wx.setNavigationBarTitle({
                    title: t.data.data.group.ptitle
                }), n.handleStyle(t.data.data.style), n.handleTime());
            }
        });
    },
    sharefriendaction: function() {
        wx.onShareAppMessage();
    },
    indexaction: function() {
        wx.navigateTo({
            url: "../index/index"
        });
    },
    buyaction: function() {
        console.log(this.data.list), wx.navigateTo({
            url: "../order/order?id=" + this.data.list.iid + "&startgroup=1&gid=" + this.data.group.id
        });
    },
    onShareAppMessage: function() {
        var t = "/yyf_oo/pages/group/group?id=" + this.data.list.id + "&gid=" + this.data.group.id;
        return console.log(t), {
            title: this.data.group.ptitle,
            path: t
        };
    },
    handleTime: function() {
        var t = this.data.group.overtime - Date.parse(new Date()) / 1e3, a = setInterval(function() {
            var o = t, n = Math.floor(o / 3600 / 24), e = n.toString();
            1 == e.length && (e = "0" + e);
            var i = Math.floor((o - 3600 * n * 24) / 3600), r = i.toString();
            1 == r.length && (r = "0" + r);
            var d = Math.floor((o - 3600 * n * 24 - 3600 * i) / 60), s = d.toString();
            1 == s.length && (s = "0" + s);
            var u = (o - 3600 * n * 24 - 3600 * i - 60 * d).toString();
            1 == u.length && (u = "0" + u), this.setData({
                countDownDay: e,
                countDownHour: r,
                countDownMinute: s,
                countDownSecond: u
            }), --t < 0 && (clearInterval(a), this.setData({
                overtime: 1
            }), this.setData({
                countDownDay: "00",
                countDownHour: "00",
                countDownMinute: "00",
                countDownSecond: "00"
            }));
        }.bind(this), 1e3);
    },
    handleStyle: function(t) {
        var a, o;
        a = "" != t.font_color ? t.font_color : "#ffffff", o = "" != t.head_color ? t.head_color : t.tcolor, 
        wx.setNavigationBarColor({
            frontColor: a,
            backgroundColor: o
        });
    }
});
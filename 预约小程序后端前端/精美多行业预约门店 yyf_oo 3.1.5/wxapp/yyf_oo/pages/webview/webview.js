var t = getApp();

Page({
    data: {
        url: "",
        blist: {},
        op: ""
    },
    onLoad: function(a) {
        var o = this;
        t.util.footer(o);
        var e = t.siteInfo.uniacid, r = wx.getStorageSync("navurl"), i = a.op;
        this.setData({
            op: i
        }), r ? (r = r.split("webview?url=")[1], this.setData({
            url: r
        })) : t.util.request({
            url: "entry/wxapp/GetWebUrl",
            data: {
                m: "yyf_oo",
                uniacid: e,
                op: i
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || o.setData({
                    url: t.data.data
                });
            }
        }), t.util.request({
            url: "entry/wxapp/GetStyle",
            data: {
                m: "yyf_oo",
                uniacid: e
            },
            cachetime: 0,
            success: function(t) {
                var a = t.data.data.stylearr;
                o.handleStyle(a);
            }
        });
    },
    handleStyle: function(t) {
        var a, o;
        a = "" != t.font_color ? t.font_color : "#ffffff", o = "" != t.head_color ? t.head_color : t.tcolor, 
        wx.setNavigationBarColor({
            frontColor: a,
            backgroundColor: o
        });
    },
    onShareAppMessage: function(t) {
        return console.log("/yyf_oo/pages/webview/webview?op=" + this.data.op), {
            path: "/yyf_oo/pages/webview/webview?op=" + this.data.op
        };
    }
});
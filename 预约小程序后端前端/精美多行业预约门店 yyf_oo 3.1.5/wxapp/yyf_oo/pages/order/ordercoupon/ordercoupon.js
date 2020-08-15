var t = getApp();

Page({
    data: {
        list: {},
        isnull: 0
    },
    onLoad: function(a) {
        this.handleStyle();
        var o = this, e = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/coupon",
            data: {
                m: "yyf_oo",
                uniacid: e,
                op: "ordercoupon",
                total: a.total
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || o.setData({
                    list: t.data.data.list,
                    isnull: t.data.data.isnull
                });
            }
        });
    },
    handleStyle: function() {
        var t, a, o = getCurrentPages(), e = o[o.length - 2].data.style;
        t = "" != e.font_color ? e.font_color : "#ffffff", a = "" != e.head_color ? e.head_color : e.tcolor, 
        wx.setNavigationBarColor({
            frontColor: t,
            backgroundColor: a
        });
    },
    receive_btn: function(t) {
        var a = t.currentTarget.dataset.isuse, o = t.currentTarget.dataset.id, e = this.data.list[o], n = getCurrentPages(), l = n[n.length - 2], i = parseFloat(l.data.total), r = parseFloat(l.data.useCouponTotal);
        if ("1" == a) {
            r && (i += r, l.data.total = i);
            var s = parseFloat(e.money);
            if ("0" == e.type) s >= i ? (r = i, i = 0) : (i = (i - s).toFixed(2), r = s); else {
                var u = e.money;
                if (-1 != u.indexOf(".")) {
                    var c = u.split(".");
                    u = parseFloat("0." + c[0] + c[1]);
                } else u = parseFloat("0." + u);
                i = (i * u).toFixed(2), r = l.data.total - i;
            }
            l.setData({
                coupon: e,
                total: i,
                useCouponTotal: r
            });
        }
        if ("cancel" == a && r) {
            var d = i + r, f = [];
            l.setData({
                coupon: f,
                total: d,
                useCouponTotal: 0
            });
        }
        wx.navigateBack({
            delta: 1
        });
    },
    cancelCoupon: function() {},
    onReady: function() {},
    onShow: function() {},
    onHide: function() {},
    onUnload: function() {},
    onPullDownRefresh: function() {},
    onReachBottom: function() {},
    onShareAppMessage: function() {}
});
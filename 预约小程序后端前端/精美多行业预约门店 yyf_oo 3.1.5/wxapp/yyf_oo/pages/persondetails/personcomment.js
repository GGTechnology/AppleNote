var t = getApp();

Page({
    data: {
        style: [],
        commentList: [],
        tcolor: "",
        stars: [ 0, 1, 2, 3, 4 ],
        normalSrc: "../../resource/images/no-star.png",
        selectedSrc: "../../resource/images/full-star.png",
        halfSrc: "../../resource/images/half-star.png",
        key: 3
    },
    onLoad: function(t) {
        this.getComment(t.id), wx.setNavigationBarTitle({
            title: t.name + "评价"
        });
    },
    getComment: function(a) {
        var o = this, e = t.siteInfo.uniacid, a = a;
        t.util.request({
            url: "entry/wxapp/Comment",
            data: {
                m: "yyf_oo",
                uniacid: e,
                id: a,
                op: "person"
            },
            cachetime: 0,
            success: function(t) {
                if (!t.data.errno) {
                    o.setData({
                        commentList: t.data.data.comment_list,
                        style: t.data.data.stylearr
                    });
                    var a, e, r = o.data.style;
                    a = "" != r.font_color ? r.font_color : "#ffffff", e = "" != r.head_color ? r.head_color : r.tcolor, 
                    wx.setNavigationBarColor({
                        frontColor: a,
                        backgroundColor: e
                    });
                }
            }
        });
    }
});
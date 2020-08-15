var t = getApp(), e = 0;

Page({
    data: {
        stars: [ 0, 1, 2, 3, 4 ],
        normalSrc: "../../resource/images/no-star.png",
        selectedSrc: "../../resource/images/full-star.png",
        halfSrc: "../../resource/images/half-star.png",
        key: 0,
        content: "",
        oid: "",
        kind: 0,
        commentInfo: "",
        person_name: ""
    },
    onLoad: function(t) {
        if (this.setData({
            oid: t.oid,
            kind: t.kind,
            person_name: t.person_name
        }), "0" != this.data.kind) e = "亲，对本次" + this.data.person_name + "还满意么？"; else var e = "亲，对本次的服务还满意么？";
        this.setData({
            commentInfo: e
        });
    },
    selectLeft: function(t) {
        var a = t.currentTarget.dataset.key;
        .5 == this.data.key && .5 == t.currentTarget.dataset.key && (a = 0), e = a, this.setData({
            key: a
        });
    },
    selectRight: function(t) {
        var a = t.currentTarget.dataset.key;
        e = a, this.setData({
            key: a
        });
    },
    startRating: function(e) {
        var a = this, n = t.siteInfo.uniacid;
        t.util.request({
            url: "entry/wxapp/Comment",
            data: {
                m: "yyf_oo",
                uniacid: n,
                score: a.data.key,
                content: a.data.content,
                op: "add",
                oid: a.data.oid,
                kind: a.data.kind
            },
            cachetime: 0,
            success: function(t) {
                t.data.errno || wx.showModal({
                    title: "提交成功",
                    content: "",
                    success: function(t) {
                        wx.navigateTo({
                            url: "../index/index"
                        });
                    }
                });
            }
        });
    },
    textareaBlur: function(t) {
        this.setData({
            content: t.detail.value
        });
    }
});
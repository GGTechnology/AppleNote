App({
    util: require("we7/resource/js/util.js"),
    globalData: {
        userInfo: null,
        code: ""
    },
    onLaunch: function() {
        var e = this, o = wx.getStorageSync("userInfo");
        "" != o.sessionid && o.sessionid || e.util.getUserInfo(function(o) {
            console.log(o);
            var n = e.siteInfo.uniacid;
            e.util.request({
                url: "entry/wxapp/GetUserInfo",
                data: {
                    m: "yyf_oo",
                    uniacid: n
                },
                cachetime: 0,
                success: function(e) {
                    e.data.errno;
                }
            });
        });
    },
    tabBar: {
        color: "#123",
        selectedColor: "#1ba9ba",
        borderStyle: "#1ba9ba",
        backgroundColor: "#fff",
        list: [ {
            pagePath: "/we7/pages/index/index",
            iconPath: "/we7/resource/icon/home.png",
            selectedIconPath: "/we7/resource/icon/homeselect.png",
            text: "首页"
        }, {
            pagePath: "/we7/pages/user/index/index",
            iconPath: "/we7/resource/icon/user.png",
            selectedIconPath: "/we7/resource/icon/userselect.png",
            text: "微擎我的"
        } ]
    },
    siteInfo: require("siteinfo.js")
});
//厦门大学计算机专业 | 前华为工程师
//专注《零基础学编程系列》  http://lblbc.cn/blog
//包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
//公众号：蓝不蓝编程
App({

  serverUrl: "http://lblbc.cn/",
  userInfo: "",

  setGlobalUserInfo: function (user) {
    //设置用户对象为缓存的方法(key,data)
    wx.setStorageSync("userInfo", user);
  },

  getGlobalUserInfo: function () {
    //获取缓存的用户对象
    return wx.getStorageSync("userInfo");
  },

  /**
   * 验证登录
   */
  checkIsLogin() {
    if (this.userInfo != '') {
      return true;
    }
    else {
      return false;
    }
  },
  login() {
    let _this = this
    wx.login({ //登录
      success(res) {
        console.log(res)
        wx.request({
          url: _this.serverUrl + 'user/loginByWx',
          method: "POST",
          header: {
            'content-type': 'application/x-www-form-urlencoded'
          },
          data: {
            code: res.code,
          },
          success(result) {
            _this.setGlobalUserInfo(result.data.data)
            // that.setGlobalUserInfo(result.data.data)
            console.log("登录成功");
          },
          fail() {
            console.log("失败");
          }
        })
      },
      fail() {
        console.log("登录失败");
      }
    })
  },
  onLaunch: function () {
    this.login()
  },
})
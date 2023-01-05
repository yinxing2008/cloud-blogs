//厦门大学计算机专业 | 前华为工程师
//专注《零基础学编程系列》  http://lblbc.cn/blog
//包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
//公众号：蓝不蓝编程
var http = require('../../utils/httputils.js');

Page({
  data: {
    blogId: 0,
    blogTitle: "",
    blogContent: ""
  },
  onLoad: function (option) {
    this.queryBlog(option.id)
  },
  methods: {
  },
  queryBlog(blogId) {
    let _this = this
    http.get('blog/blogs/' + blogId, '',
      function (resp) {
        _this.setData({
          blogId: blogId,
          blogTitle: resp.data.title,
          blogContent: resp.data.content
        })
      },
      function (err) { })
  },
  modifyBlog(e) {
    var params = {
      title: e.detail.value.title,
      content: e.detail.value.content,
    }
    http.put('blog/blogs/'+this.data.blogId, params,
      function (resp) {
        wx.navigateBack()
      },
      function (err) { })
  }

})
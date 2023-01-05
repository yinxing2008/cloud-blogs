//index.js
//获取应用实例
var http = require('../../utils/httputils.js');
const app = getApp()

Page({
  data: {
    dataList: [],
  },
  onLoad: function () {
    this.getBlogList()
  },
  onShow: function () {
    this.getBlogList()
  },
  methods: {
  },
  getBlogList() {
    let _this = this
    http.get('blog/blogs', '',
      function (resp) {
        _this.setData({
          dataList: resp.data
        })
      },
      function (err) { })
  },
  addBlog(){
    wx.navigateTo({
      url: '/pages/blog-add/blog-add'
    })
  },
  viewBlog(e) {
    let blogId = e.currentTarget.dataset['blogid'];
    wx.navigateTo({
      url: '/pages/blog-edit/blog-edit?id=' + blogId
    })
  },
  longPressed(e) {
    let _this = this
    let blogid = e.currentTarget.dataset['blogid'];
    wx.showActionSheet({
      itemList: ['删除'],
      success: function (res) {
        _this.deleteBlog(blogid)
      },
      fail: function (res) { }
    })
  },
  deleteBlog(blogid) {
    let _this = this
    http.del('blog/blogs/' + blogid, '',
      function (resp) {
        _this.getBlogList()
      },
      function (err) { })
  },

})
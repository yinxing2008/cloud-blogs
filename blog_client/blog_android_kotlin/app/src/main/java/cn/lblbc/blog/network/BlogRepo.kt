/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
package cn.lblbc.blog.network

import cn.lblbc.blog.base.BaseRepository
import cn.lblbc.blog.network.request.AddBlogRequest
import cn.lblbc.blog.network.request.LoginRequest
import cn.lblbc.blog.network.request.ModifyBlogRequest
import cn.lblbc.blog.network.request.RegisterRequest

class BlogRepo : BaseRepository() {
    suspend fun login(userName: String, password: String) = apiService.login(LoginRequest(userName, password))
    suspend fun register(userName: String, password: String) = apiService.register(RegisterRequest(userName, password))
    suspend fun queryBlogList() = apiService.queryBlogList()
    suspend fun queryBlog(blogId: Int) = apiService.queryBlog(blogId)
    suspend fun addBlog(title: String, content: String) = apiService.addBlog(AddBlogRequest(title, content))
    suspend fun modifyBlog(id: Int, title: String, content: String) = apiService.modifyBlog(id, ModifyBlogRequest(title, content))
    suspend fun delBlog(blogId: Int) = apiService.delBlog(blogId)
}
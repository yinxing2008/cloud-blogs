/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
package cn.lblbc.blog.network.request

class LoginRequest(
    val name: String = "",
    val password: String = ""
)

class RegisterRequest(
    val name: String = "",
    val password: String = ""
)

class AddBlogRequest(
    val title: String = "",
    val content: String = ""
)

class ModifyBlogRequest(
    val title: String = "",
    val content: String = ""
)
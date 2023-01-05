package cn.lblbc.blog.network

/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
import cn.lblbc.blog.network.request.AddBlogRequest
import cn.lblbc.blog.network.request.LoginRequest
import cn.lblbc.blog.network.request.ModifyBlogRequest
import cn.lblbc.blog.network.request.RegisterRequest
import cn.lblbc.blog.network.response.Blog
import cn.lblbc.blog.network.response.LoginResp
import cn.lblbc.blog.network.response.Result
import retrofit2.http.*

interface ApiService {

    @POST("user/login")
    @Headers("ignoreToken:true")
    suspend fun login(@Body request: LoginRequest): Result<LoginResp?>?

    @POST("user/register")
    @Headers("ignoreToken:true")
    suspend fun register(@Body request: RegisterRequest): Result<LoginResp?>?

    @GET("blog/blogs")
    suspend fun queryBlogList(): Result<List<Blog>?>?

    @GET("blog/blogs/{blogId}")
    suspend fun queryBlog(@Path("blogId") blogId: Int): Result<Blog?>?

    @DELETE("blog/blogs/{blogId}")
    suspend fun delBlog(@Path("blogId") blogId: Int): Result<String?>?

    @POST("blog/blogs")
    suspend fun addBlog(@Body request: AddBlogRequest): Result<String?>?

    @PUT("blog/blogs/{blogId}")
    suspend fun modifyBlog(@Path("blogId") blogId: Int, @Body request: ModifyBlogRequest): Result<String?>?

}
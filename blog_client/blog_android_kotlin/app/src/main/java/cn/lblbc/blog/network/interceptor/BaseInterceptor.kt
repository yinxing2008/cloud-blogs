/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
package cn.lblbc.blog.network.interceptor

import cn.lblbc.blog.utils.Constants.LOGIN_URL
import okhttp3.Interceptor
import okhttp3.Request
import okhttp3.Response
import java.io.IOException

/**
 * okhttp基础拦截器，对指定接口不做拦截
 */

abstract class BaseInterceptor : Interceptor {

    @Throws(IOException::class)
    override fun intercept(chain: Interceptor.Chain): Response {
        val request = chain.request()
        return if (shouldIntercept(request)) {
            interceptMe(chain)
        } else {
            chain.proceed(request)
        }
    }

    private fun shouldIntercept(request: Request) = !request.url().url().path.endsWith(LOGIN_URL)
    abstract fun interceptMe(chain: Interceptor.Chain): Response
}

package cn.lblbc.blog.viewmodel

import cn.lblbc.blog.base.BaseViewModel
import cn.lblbc.blog.network.BlogRepo
import cn.lblbc.blog.utils.Constants.SP_KEY_TOKEN
import cn.lblbc.blog.utils.Constants.SP_KEY_USER_ID
import cn.lblbc.lib.utils.SpUtil

/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
class LoginViewModel : BaseViewModel() {
    private val blogRepo by lazy { BlogRepo() }

    fun login(
        userName: String, password: String,
        onSuccess: (() -> Unit)? = null,
        onFailure: ((msg: String) -> Unit)? = null,
        onComplete: (() -> Unit)? = null
    ) {
        launch(
            {
                val resp = blogRepo.login(userName, password)
                if (resp?.isSuccess() == true) {
                    SpUtil.put(SP_KEY_TOKEN, resp?.data?.token ?: "")
                    SpUtil.put(SP_KEY_USER_ID, resp?.data?.id ?: 0L)
                    onSuccess?.invoke()
                } else {
                    onFailure?.invoke(resp?.msg ?: "")
                }
            },
            { onFailure?.invoke(it.message ?: "error") },
            { onComplete?.invoke() })
    }

    fun register(
        userName: String, password: String,
        onSuccess: (() -> Unit)? = null,
        onFailure: ((msg: String) -> Unit)? = null,
        onComplete: (() -> Unit)? = null
    ) {
        launch(
            {
                val resp = blogRepo.register(userName, password)
                if (resp?.isSuccess() == true) {
                    SpUtil.put(SP_KEY_TOKEN, resp?.data?.token ?: "")
                    SpUtil.put(SP_KEY_USER_ID, resp?.data?.id ?: 0L)
                    onSuccess?.invoke()
                } else {
                    onFailure?.invoke(resp?.msg ?: "")
                }
            },
            { onFailure?.invoke(it.message ?: "error") },
            { onComplete?.invoke() })
    }
}
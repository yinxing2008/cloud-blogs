package cn.lblbc.blog.viewmodel

import androidx.lifecycle.MutableLiveData
import cn.lblbc.blog.base.BaseViewModel
import cn.lblbc.blog.network.BlogRepo
import cn.lblbc.blog.network.response.Blog
import cn.lblbc.lib.utils.ToastUtil

/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
class BlogViewModel : BaseViewModel() {
    private val blogListRepo by lazy { BlogRepo() }
    val blog: MutableLiveData<Blog> = MutableLiveData()

    fun queryBlog(
        blogId: Int,
        onSuccess: (() -> Unit)? = null,
        onFailure: ((msg: String) -> Unit)? = null,
        onComplete: (() -> Unit)? = null
    ) {
        launch(
            {
                blog.value = blogListRepo.queryBlog(blogId)?.data
                onSuccess?.invoke()
            },
            { onFailure?.invoke(it.message ?: "") },
            { onComplete?.invoke() })
    }


    fun addBlog(
        title: String,
        content: String,
        onSuccess: (() -> Unit)? = null,
        onFailure: ((msg: String) -> Unit)? = null,
        onComplete: (() -> Unit)? = null
    ) {
        launch(
            {
                val resp = blogListRepo.addBlog(title, content)
                resp?.let {
                    if (it.isSuccess()) {
                        onSuccess?.invoke()
                    } else {
                        ToastUtil.toast(it.msg)
                    }
                }
            },
            { onFailure?.invoke(it.message ?: "") },
            { onComplete?.invoke() })
    }

    fun modifyBlog(
        blogId: Int,
        title: String,
        content: String,
        onSuccess: (() -> Unit)? = null,
        onFailure: ((msg: String) -> Unit)? = null,
        onComplete: (() -> Unit)? = null
    ) {
        launch(
            {
                blogListRepo.modifyBlog(blogId, title, content)
                onSuccess?.invoke()
            },
            { onFailure?.invoke(it.message ?: "") },
            { onComplete?.invoke() })
    }

    fun deleteBlog(
        blogId: Int,
        onSuccess: (() -> Unit)? = null,
        onFailure: ((msg: String) -> Unit)? = null,
        onComplete: (() -> Unit)? = null
    ) {
        launch(
            {
                blogListRepo.delBlog(blogId)
                onSuccess?.invoke()
            },
            { onFailure?.invoke(it.message ?: "") },
            { onComplete?.invoke() })
    }
}
package cn.lblbc.blog.viewmodel

import androidx.lifecycle.MutableLiveData
import cn.lblbc.blog.base.BaseViewModel
import cn.lblbc.blog.network.BlogRepo
import cn.lblbc.blog.network.response.Blog
/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
class BlogListViewModel : BaseViewModel() {
    private val blogListRepo by lazy { BlogRepo() }
    val dataList: MutableLiveData<List<Blog>> = MutableLiveData()

    fun queryBlogList(
        onSuccess: (() -> Unit)? = null,
        onFailure: ((msg: String) -> Unit)? = null,
        onComplete: (() -> Unit)? = null
    ) {
        launch(
            {
                dataList.value = blogListRepo.queryBlogList()?.data
                onSuccess?.invoke()
            },
            { onFailure?.invoke(it.message ?: "") },
            { onComplete?.invoke() })
    }
}
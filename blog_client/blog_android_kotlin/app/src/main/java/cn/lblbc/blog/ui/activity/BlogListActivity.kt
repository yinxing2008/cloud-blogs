package cn.lblbc.blog.ui.activity

import android.content.Intent
import androidx.lifecycle.Observer
import cn.lblbc.blog.R
import cn.lblbc.blog.base.BaseVmActivity
import cn.lblbc.blog.network.response.Blog
import cn.lblbc.blog.ui.adapter.BlogListAdapter
import cn.lblbc.blog.utils.Constants
import cn.lblbc.blog.utils.Constants.EXTRA_KEY_BLOG_CONTENT
import cn.lblbc.blog.utils.Constants.EXTRA_KEY_BLOG_ID
import cn.lblbc.blog.utils.Constants.EXTRA_KEY_BLOG_TITLE
import cn.lblbc.blog.viewmodel.BlogListViewModel
import cn.lblbc.lib.utils.SpUtil
import kotlinx.android.synthetic.main.activity_blog_list.*

/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
class BlogListActivity : BaseVmActivity<BlogListViewModel>() {
    private val adapter = BlogListAdapter()
    override fun viewModelClass() = BlogListViewModel::class.java
    override fun layoutResId(): Int = R.layout.activity_blog_list

    override fun initView() {
        if (isLoggedIn()) {
            rv.adapter = adapter
            adapter.setOnItemClick(this::onItemClick)
        } else {
            startActivity(Intent(this@BlogListActivity, LoginActivity::class.java))
            finish()
        }
    }

    private fun isLoggedIn(): Boolean {
        var token = SpUtil.get(Constants.SP_KEY_TOKEN, "")
        return !token.isNullOrEmpty()
    }

    override fun initData() {
        mViewModel.queryBlogList()
    }

    override fun initListeners() {
        addIv.setOnClickListener {
            startActivity(Intent(this, AddBlogActivity::class.java))
        }
    }

    override fun observe() {
        mViewModel.dataList.observe(this, Observer { adapter.setData(it) })
    }

    private fun onItemClick(blog: Blog) {
        val intent = Intent(this, EditBlogActivity::class.java)
        intent.putExtra(EXTRA_KEY_BLOG_ID, blog.id)
        intent.putExtra(EXTRA_KEY_BLOG_TITLE, blog.title)
        intent.putExtra(EXTRA_KEY_BLOG_CONTENT, blog.content)
        startActivity(intent)
    }

    override fun onResume() {
        super.onResume()
        initData()
    }
}

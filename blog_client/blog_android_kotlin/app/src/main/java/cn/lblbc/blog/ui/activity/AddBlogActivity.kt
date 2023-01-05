package cn.lblbc.blog.ui.activity

import cn.lblbc.blog.R
import cn.lblbc.blog.base.BaseVmActivity
import cn.lblbc.blog.viewmodel.BlogViewModel
import kotlinx.android.synthetic.main.activity_edit_blog.*
/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
class AddBlogActivity : BaseVmActivity<BlogViewModel>() {
    override fun viewModelClass() = BlogViewModel::class.java
    override fun layoutResId(): Int = R.layout.activity_add_blog

    override fun initView() {
        initToolbar()
    }

    private fun initToolbar() {
        toolbar.inflateMenu(R.menu.add_blog)
        toolbar.setNavigationOnClickListener { finish() }
        toolbar.setOnMenuItemClickListener { item ->
            when (item.itemId) {
                R.id.action_save -> saveBlog()
            }
            false
        }
    }

    private fun saveBlog() {
        mViewModel.addBlog(titleEt.text.toString(), contentEt.text.toString())
        finish()
    }
}

package cn.lblbc.blog

import android.annotation.SuppressLint
import android.app.Application
import android.content.Context
import cn.lblbc.lib.utils.SpUtil
import cn.lblbc.lib.utils.ToastUtil

/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
class App : Application() {

    override fun onCreate() {
        super.onCreate()
        context = this
        SpUtil.init(this)
        ToastUtil.init(this)
    }

    companion object {
        @SuppressLint("StaticFieldLeak")
        lateinit var context: Context
    }

}
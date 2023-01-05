/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
const { HttpException } = require('@core/http-exception')

const catchError = async (ctx, next) => {
  try {
    await next()

  } catch (error) {
    const isHttpException = error instanceof HttpException;

    if (isHttpException) {
      ctx.body = {
        msg: error.msg,
        code: -1
      }
      ctx.response.status = error.code

    } else {
      ctx.body = {
        msg: "未知错误！",
        code: -1
      }
      ctx.response.status = 500
    }
  }
}

module.exports = catchError

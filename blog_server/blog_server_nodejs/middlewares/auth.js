/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
const jwt = require('jsonwebtoken')

class Auth {
  get m() {
    // token 检测
    // token 开发者 传递令牌
    // token body header
    // HTTP 规定 身份验证机制 HttpBasicAuth
    return async (ctx, next) => {
      const token = ctx.req.headers.authorization;
      try {
        var decode = jwt.verify(token, global.config.security.secretKey);
      } catch (error) {
        var errMsg = error.message
        // token 不合法 过期
        if (error.name === 'TokenExpiredError') {
          errMsg = "token已过期"
        }

        throw new global.errs.Forbidden(errMsg);
      }

      ctx.auth = {
        userId: decode.userId
      }

      await next()
    }
  }

}

module.exports = {
  Auth
}

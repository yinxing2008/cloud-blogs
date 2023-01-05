/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
const { UserDao } = require('@dao/user')
const { generateToken } = require('@core/util')

class LoginManager {
  static async userLogin(params) {
    const { name, password } = params
    // 验证账号密码是否正确
    const [err, user] = await UserDao.checkPassword(name, password);
    if (!err) {
      return [null, generateToken(user.id), user.id]
    } else {
      return [err, null]
    }
  }
}

module.exports = {
  LoginManager
}

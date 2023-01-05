/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
const { User } = require('@models/user')
const bcrypt = require('bcryptjs')

class UserDao {
  static async addUser(params) {
    const { name, password } = params
    const hasUser = await User.findOne({
      where: {
        name
      }
    });

    if (hasUser) {
      return ['用户已存在', null]
    }

    const user = new User();
    user.name = name
    user.password = password

    try {
      const res = await user.save();
      const data = {
        code: 200,
        name: res.name
      }
      return [null, data]
    } catch (err) {
      return [err, null]
    }
  }

  static async checkPassword(name, plainPassword) {
    try {
      // 查询用户是否存在
      const user = await User.findOne({
        where: { name }
      })

      if (!user) {
        return ['账号不存在或者密码不正确', null]
      }

      // 验证密码是否正确
      const correct = bcrypt.compareSync(plainPassword, user.password);
      if (!correct) {
        return ['账号不存在或者密码不正确', null]
      }

      return [null, user]
    } catch (err) {
      return [err, null]
    }
  }

  // 查询用户信息
  static async detail(id) {
    try {
      const filter = {
        id
      }
      // 查询用户是否存在
      const user = await User.findOne({
        where: filter
      })

      if (!user) {
        throw new global.errs.AuthFailed('账号不存在或者已被禁用，请联系管理员！')
      }

      return [null, user]
    } catch (err) {
      return [err, null]
    }
  }
}

module.exports = {
  UserDao
}

/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
const {
  Rule,
  LinValidator
} = require('@core/lin-validator-v2')

const { User } = require('@models/user')

class RegisterValidator extends LinValidator {
  constructor() {
    super();
    this.password = [
      // 用户密码指定范围
      new Rule('isLength', '密码至少1个字符，最多22个字符', {
        min: 1,
        max: 22
      })
    ]
    this.name = [
      new Rule('isLength', '账号长度必须在1~16之间', {
        min: 1,
        max: 16
      }),
    ]
  }

}


class UserLoginValidator extends LinValidator {
  constructor() {
    super();
    this.password = [
      // 用户密码指定范围
      new Rule('isLength', '密码至少1个字符，最多22个字符', {
        min: 1,
        max: 22
      })
    ]
    this.name = [
      new Rule('isLength', '账号长度必须在1~16之间', {
        min: 1,
        max: 16
      }),
    ]
  }
}

class PositiveIdParamsValidator extends LinValidator {
  constructor() {
    super();
    this.id = [
      new Rule('isInt', '请输入正整数', { min: 1 })
    ]
  }
}
module.exports = {
  RegisterValidator,
  UserLoginValidator,
  PositiveIdParamsValidator
}

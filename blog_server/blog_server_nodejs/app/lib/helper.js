/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
class Resolve {
  fail(msg = {}, code = -1) {
    return {
      msg,
      code
    }
  }

  success(msg = 'success', code = 0) {
    return {
      msg,
      code
    }
  }

  json(data, msg = 'success', code = 0) {
    return {
      code,
      msg,
      data
    }
  }
}

module.exports = {
  Resolve
}

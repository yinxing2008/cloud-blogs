/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
const { sequelize } = require('@core/db')
const { Model, DataTypes } = require('sequelize')
class Blog extends Model {
}

Blog.init({
  id: {
    type: DataTypes.INTEGER(10).UNSIGNED,
    primaryKey: true,
    autoIncrement: true
  },
  title: {
    type: DataTypes.STRING(128),
    allowNull: false
  },
  content: {
    type: DataTypes.TEXT,
    allowNull: false
  }, 
  user_id: {
    type: DataTypes.INTEGER(10).UNSIGNED,
    allowNull: false
  },
}, {
  sequelize,
  modelName: 'blog',
  tableName: 'blog'
})

module.exports = {
  Blog
}

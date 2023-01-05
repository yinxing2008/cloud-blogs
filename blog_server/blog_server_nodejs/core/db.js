/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
const Sequelize = require('sequelize')

// const sequelize = new Sequelize('lblbc_blog', 'root', '12345678', {
//   dialect: 'mysql',
//   host: 'localhost',
//   port: 3306,
//   logging: false,
//   timezone: '+08:00',
//   define: {
//     // create_time && update_time
//     timestamps: true,
//     // delete_time
//     paranoid: true,
//     // 把驼峰命名转换为下划线
//     underscored: true
//   }
// })

const sequelize = new Sequelize({
  host: 'localhost',
  dialect: 'sqlite',

  pool: {
    max: 5,
    min: 0,
    acquire: 30000,
    idle: 10000
  },
  storage: './lblbc_blog.db',
  operatorsAliases: false
});

// 创建模型
sequelize.sync({ force: false })

sequelize.authenticate().then(res => {
  console.log('Connection has been established successfully.');
}).catch(err => {
  console.error('Unable to connect to the database:', err);
})

// sequelize.query("CREATE DATABASE IF NOT EXISTS boblog DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci").then(res=>{
//   console.log('CREATE DATABASE SUCCESS!')
// }).catch(err => {
//   console.log('CREATE DATABASE FAIL!', err)
// })


module.exports = {
  sequelize
}

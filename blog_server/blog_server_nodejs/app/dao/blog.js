/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
const { Blog } = require('@models/blog')

// 定义博客模型
class BlogDao {

  // 创建博客
  static async create(v, userId) {
    const blog = new Blog();

    blog.title = v.get('body.title');
    blog.content = v.get('body.content');
    blog.user_id = userId;

    try {
      const res = await blog.save();
      return [null, res]
    } catch (err) {
      console.log(err)
      return [err, null]
    }
  }

  //查询指定用户博客
  static async queryBlogs(userId) {
    try {
      const blog = await Blog.findAndCountAll({
        where: {
          user_id: userId
        }
      });
      let rows = blog.rows
      return [null, rows]
    } catch (err) {
      return [err, null]
    }
  }

  // 删除博客
  static async deleteBlog(id) {
    // 检测是否存在博客
    const blog = await Blog.findOne({
      where: { id }
    });
    // 不存在抛出错误
    if (!blog) {
      throw new global.errs.NotFound('没有找到相关博客');
    }

    try {
      const res = await blog.destroy({force:true})
      return [null, res]
    } catch (err) {
      return [err, null]
    }
  }

  // 更新博客
  static async update(v, blogId, userId) {
    const blog = await Blog.findByPk(blogId);
    if (!blog) {
      throw new global.errs.NotFound('没有找到相关博客');
    }

    // 更新博客
    blog.title = v.get('body.title');
    blog.content = v.get('body.content');
    blog.user_id = userId;

    try {
      const res = await blog.save();
      return [null, res]
    } catch (err) {
      return [err, null]
    }
  }


  // 博客详情
  static async detail(id, query) {
    const { keyword } = query
    try {
      let filter = {
        id,
        deleted_at: null
      }

      let blog = await Blog.findOne({
        where: filter,
      });

      if (!blog) {
        throw new global.errs.NotFound('没有找到相关博客');
      }

      return [null, blog];
    } catch (err) {
      return [err, null]
    }
  }

}

module.exports = {
  BlogDao
}

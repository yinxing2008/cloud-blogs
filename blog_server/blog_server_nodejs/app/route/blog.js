/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
const Router = require('koa-router');

const {
  BlogValidator,
  PositiveIdParamsValidator
} = require('@validators/blog');

const { Auth } = require('@middlewares/auth');
const { BlogDao } = require('@dao/blog');
const { Resolve } = require('@lib/helper');
const res = new Resolve();

const router = new Router({
  prefix: '/blog'
})

/**
 * 创建博客
 */
router.post('/blogs', new Auth().m, async (ctx) => {

  // 通过验证器校验参数是否通过
  const v = await new BlogValidator().validate(ctx);
  var userId = ctx.auth.userId
  // 创建博客
  const [err, data] = await BlogDao.create(v, userId);
  if (!err) {
    // 返回结果
    ctx.response.status = 200;
    ctx.body = res.success('');
  } else {
    ctx.body = res.fail(err);
  }
});

/**
 * 删除博客
 */
router.delete('/blogs/:id', new Auth().m, async (ctx) => {

  // 通过验证器校验参数是否通过
  const v = await new PositiveIdParamsValidator().validate(ctx);

  // 获取博客ID参数
  const id = v.get('path.id');
  // 删除博客
  const [err, data] = await BlogDao.deleteBlog(id);
  if (!err) {
    ctx.response.status = 200;
    ctx.body = res.success('删除博客成功');
  } else {
    ctx.body = res.fail(err);
  }
})

/**
 * 更新博客
 */
router.put('/blogs/:blogId', new Auth().m, async (ctx) => {
  // 通过验证器校验参数是否通过
  const v = await new PositiveIdParamsValidator().validate(ctx);
  const blogId = v.get('path.blogId');
  // 更新博客
  const [err, data] = await BlogDao.update(v, blogId, ctx.auth.userId);
  if (!err) {
    ctx.response.status = 200;
    ctx.body = res.success('更新博客成功');
  } else {
    ctx.body = res.fail(err);
  }
})


/**
 * 获取博客列表
 */
router.get('/blogs', new Auth().m, async (ctx) => {
  var userId = ctx.auth.userId
  const [err, data] = await BlogDao.queryBlogs(userId);
  if (!err) {
    ctx.response.status = 200;
    ctx.body = res.json(data)
  } else {
    ctx.body = res.fail(err)
  }
});

/**
 * 查询博客详情
 */
router.get('/blogs/:id', async (ctx) => {

  // 通过验证器校验参数是否通过
  const v = await new PositiveIdParamsValidator().validate(ctx);
  // 获取博客ID参数
  const id = v.get('path.id');
  // 查询博客
  const [err, data] = await BlogDao.detail(id, ctx.query);
  if (!err) {
    ctx.response.status = 200;
    ctx.body = res.json(data);
  } else {
    ctx.body = res.fail(err);
  }
})

module.exports = router

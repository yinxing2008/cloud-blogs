/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
const Router = require('koa-router')

const {
    RegisterValidator,
    PositiveIdParamsValidator,
    UserLoginValidator
} = require('@validators/user')

const { UserDao } = require('@dao/user');
const { LoginManager } = require('@service/login');
const { Resolve } = require('@lib/helper');
const res = new Resolve();

const router = new Router({
    prefix: '/user'
})

// 注册
router.post('/register', async (ctx) => {
    // 通过验证器校验参数是否通过
    const v = await new RegisterValidator().validate(ctx);
    const name = v.get('body.name');
    const password = v.get('body.password');

    // 创建用户
    const [err, data] = await UserDao.addUser({
        password,
        name
    });

    if (!err) {
        const [errToken, token, id] = await LoginManager.userLogin({
            name,
            password
        });
        if (!errToken) {
            data.token = token
            data.id = id
        }
        // 返回结果
        ctx.response.status = 200;
        ctx.body = res.json(data);

    } else {
        ctx.body = res.fail(err)
    }

})

// 登录
router.post('/login', async (ctx) => {

    const v = await new UserLoginValidator().validate(ctx);

    let [err, token, id] = await LoginManager.userLogin({
        name: v.get('body.name'),
        password: v.get('body.password')
    });

    if (!err) {
        let [err, data] = await UserDao.detail(id);
        if (!err) {
            data.setDataValue('token', token)
            ctx.response.status = 200;
            ctx.body = res.json(data);
        }
    } else {
        ctx.body = res.fail(err, err.msg);
    }
});


module.exports = router

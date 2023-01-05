import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)
const router = new Router({
    routes: [

        {
            path: "/blog/login",
            name: "Login",
            component: () =>
                import( '@/views/Login'),
        },
        {
            path: "/blog/list",
            name: "BlogList",
            component: () =>
                import( '@/views/BlogList'),
        },
        {
            path: "/blog/add",
            name: "AddBlog",
            component: () =>
                import( '@/views/AddBlog'),
            meta: {
                requiresAuth: true,
            }
        },
        {
            path: "/blog/modify",
            name: "ModifyBlog",
            component: () =>
                import( '@/views/ModifyBlog'),
            meta: {
                requiresAuth: true,
            }
        }
    ]
})

router.beforeEach((to, from, next) => {
    if (to.matched.some(record => record.meta.requiresAuth)) {
        if (sessionStorage.getItem("user_token") == null) {
            next({
                name: 'Login',
            })
        } else {
            next()
        }
    } else {
        next()
    }
})

export default router

import { createRouter, createWebHashHistory, RouteRecordRaw } from "vue-router";
const routes: Array<RouteRecordRaw> = [
	{
		path: "/blog",
		name: "BlogList",
		meta: {
			title: "首页",
			keepAlive: true
		},
		component: () => import("../views/BlogList.vue"),
	},
	{
		path: "/blog/login",
		name: "Login",
		meta: {
			title: "登录",
			keepAlive: true
		},
		component: () => import("../views/Login.vue"),
	}, 
	{
		path: "/blog/addBlog",
		name: "AddBlog",
		meta: {
			title: "新建博客",
			keepAlive: true
		},
		component: () => import("../views/AddBlog.vue"),
	}, 
	{
		path: "/blog/modifyBlog",
		name: "ModifyBlog",
		meta: {
			title: "编辑博客",
			keepAlive: true
		},
		component: () => import("../views/ModifyBlog.vue"),
	},
];
const router = createRouter({
	history: createWebHashHistory(),
	routes
});
export default router;
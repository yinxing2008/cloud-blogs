<?php
//厦门大学计算机专业 | 前华为工程师
//专注《零基础学编程系列》  http://lblbc.cn/blog
//包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
//公众号：蓝不蓝编程

use think\facade\Route;

Route::post('user/register', 'LoginController/register');
Route::post('user/login', 'LoginController/login');

Route::get('blog/blogs/:blogId', 'BlogController/queryBlog');
Route::get('blog/blogs', 'BlogController/list');
Route::post('blog/blogs', 'BlogController/addBlog');
Route::put('blog/blogs/:blogId', 'BlogController/modifyBlog');
Route::delete('blog/blogs/:blogId', 'BlogController/deleteBlog');
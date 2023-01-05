<?php
//厦门大学计算机专业 | 前华为工程师
//专注《零基础学编程系列》  http://lblbc.cn/blog
//包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
//公众号：蓝不蓝编程
declare(strict_types=1);

namespace app\controller;

use app\model\Blog;
use Exception;
use think\facade\Request;
use app\JwtUtils;


class BlogController
{
    public function list()
    {
        $authorization = Request::header('Authorization');
        $userId = JwtUtils::getUserIdFromToken($authorization);
        $data = Blog::where('user_id', $userId)->select();
        return json([
            'code' => 0,
            'msg' => "",
            'data' =>  $data
        ]);
    }

    public function queryBlog($blogId)
    {
        $authorization = Request::header('Authorization');
        $userId = JwtUtils::getUserIdFromToken($authorization);
        $data = Blog::where('id', $blogId)->find();
        return json([
            'code' => 0,
            'msg' => "",
            'data' =>  $data
        ]);
    }

    public function addBlog()
    {
        $authorization = Request::header('Authorization');
        $userId = JwtUtils::getUserIdFromToken($authorization);
        $requestData = Request::post();
        $requestData['user_id'] = $userId;
        $create = Blog::create($requestData);

        return json([
            'code' => 0,
            'msg' => ""
        ]);
    }

    public function modifyBlog($blogId)
    {
        $authorization = Request::header('Authorization');
        $userId = JwtUtils::getUserIdFromToken($authorization);

        $requestData = Request::post();
        $blog = Blog::where('id', $blogId)->find();
        $data = Request::only(['title','content']);
        $blog->save($data);

        return json([
            'code' => 0,
            'msg' => ""
        ]);
    }

    public function deleteBlog($blogId)
    {
        Blog::destroy($blogId);

        return json([
            'code' => 0,
            'msg' => ""
        ]);
    }
}

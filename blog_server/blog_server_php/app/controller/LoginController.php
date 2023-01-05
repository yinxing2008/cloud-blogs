<?php
//厦门大学计算机专业 | 前华为工程师
//专注《零基础学编程系列》  http://lblbc.cn/blog
//包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
//公众号：蓝不蓝编程
declare(strict_types=1);

namespace app\controller;

use app\model\User;
use Exception;
use think\facade\Request;
use app\JwtUtils;


class LoginController
{
    public function login()
    {
        $requestData = Request::post();
        $user = User::where('name', $requestData['name'])->find();
        if ($user !== null && password_verify($requestData['password'], $user->password)) {
            $token = JwtUtils::createjwt($user->id);
            return json([
                'code' => 0,
                'msg' => "",
                'data' => [ 'token' => $token ]
            ]);
        } else {
            return json([
                'code' => -1,
                'msg' => "用户名或密码错误"
            ]);
        }
    }
    

    public function register()
    {
        $requestData = Request::post();

        $user = User::where('name', $requestData['name'])->find();
        if ($user !== null) {
            return json([
                'code' => -1,
                'msg' => "用户已存在"
            ]);
        }

        $create = User::create($requestData);
        $user = User::find($create->id);
        $token = JwtUtils::createjwt($user->id);
        return json([
            'code' => 0,
            'msg' => "",
            'data' => [ 'token' => $token ]
        ]);
    }
}

<?php
//厦门大学计算机专业 | 前华为工程师
//专注《零基础学编程系列》  http://lblbc.cn/blog
//包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
//公众号：蓝不蓝编程
declare(strict_types=1);

namespace app\model;

use think\model\Pivot;


class Blog extends Pivot
{
    protected $table = 'blog';
    
    // 定义数据输出时需要隐藏的字段
    protected $hidden = ['user_id'];
}

<?php
 
namespace app;
 
use app\BaseController;
use Firebase\JWT\ExpiredException;
use Firebase\JWT\JWT as JWTUtil;
use Firebase\JWT\Key;
 
class JwtUtils
{
     /**
     * 根据json web token设置的规则生成token
     * @return \think\response\Json
     */
    public static function createjwt($id)
    {
        $key = md5('lblbc'); //jwt的签发密钥，验证token的时候需要用到
        $time = time(); //签发时间
        $expire = $time + 14400; //过期时间
        $token = array("user_id" => $id);
        $jwt = JWTUtil::encode($token,$key,'HS256');
        return $jwt;
    }
 
    /**
     * 验证token
     * @return \think\response\Json
     */
    public static function getUserIdFromToken($jwt)
    {
        $key = md5('lblbc'); //jwt的签发密钥，验证token的时候需要用到
        try{
            $jwtAuth = json_encode(JWTUtil::decode($jwt,new Key($key,'HS256')));
            $authInfo = json_decode($jwtAuth,true);
            if (!$authInfo['user_id']){
                return "";
            }
            return $authInfo['user_id'];
        }catch (\Exception $e){
            return "";
        }
    }
 
     /**
     * 从请求信息中获取token值
     * @return false|string
     */
    public static function getRequestToken()
    {
        if (empty($_SERVER['HTTP_AUTHORIZATION'])) {
            return false;
        }
 
        $header = $_SERVER['HTTP_AUTHORIZATION'];
        $method = 'bearer';
        //去除token中可能存在的bearer标识
        return trim(str_ireplace($method, '', $header));
    }
 
}
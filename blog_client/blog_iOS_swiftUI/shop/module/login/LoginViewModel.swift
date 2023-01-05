// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import Foundation
import SwiftyJSON
import HandyJSON

class LoginViewModel{
    static let shared = LoginViewModel()
    private var storeName = "user_info"
    
    var userInfo : UserInfo?
    
    private init() { load() }
    
    func load(){
        if let data = UserDefaults.standard.object(forKey: storeName) as? Data{
            self.userInfo = try! PropertyListDecoder().decode(UserInfo.self, from: data)
        }
    }
    
    func isLoggedIn()  -> Bool{
        return userInfo != nil
    }
    
    func save(userInfo : UserInfo){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(userInfo),forKey: storeName)
    }
    
    func quitLogin() {
        UserDefaults.standard.removeObject(forKey: storeName)
        userInfo = nil
    }
    
    func login(name: String, password: String, callback: @escaping((Bool,String)->())) {
        let params = [
            "name": name,
            "password": password
        ]
        
        LblProvider.request(.login(params:params)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let resp = JSONDeserializer<LoginResp>.deserializeFrom(json: json.description) {
                    self.userInfo = resp.data
                    if(self.userInfo != nil){
                        self.save(userInfo: self.userInfo!)
                    }
                    callback(resp.isSuccess(),resp.msg)
                }
            }
        }
    }
    
    func register(name: String, password: String, callback: @escaping((Bool,String)->())) {
        let params = [
            "name": name,
            "password": password
        ]
        
        LblProvider.request(.register(params:params)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let resp = JSONDeserializer<LoginResp>.deserializeFrom(json: json.description) {
                    self.userInfo = resp.data
                    if(self.userInfo != nil){
                        self.save(userInfo: self.userInfo!)
                    }
                    callback(resp.isSuccess(),resp.msg)
                }
            }
        }
    }
}

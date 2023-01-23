// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》http://lblbc.cn/blog
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程


import Foundation
import HandyJSON

struct CommonResp: HandyJSON,Codable{
    var code = 0
    var msg : String = ""
    var data : String?
    func isSuccess() -> Bool{
        return code == 0
    }
}

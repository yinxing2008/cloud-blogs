// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import Foundation
import HandyJSON

struct Goods: HandyJSON,Codable,Identifiable,Hashable{
    var id: String = ""
    var name: String = ""
    var price = 0
    var longPic: String?
    var squarePic: String?
}

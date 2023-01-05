// 厦门大学计算机专业 | 前华为工程师
// 分享编程技术，没啥深度，但看得懂，适合初学者。
// Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import UIKit
import SwiftyJSON
import HandyJSON

class CategoryViewModel: ObservableObject {
    @Published var categoryList:[CategoryInfo] = []
    @Published var goodsList:[Goods] = []
    
    func queryGoodsByCategory(categoryId: String) {
        LblProvider.request(.queryGoodsByCategory(categoryId: categoryId)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let resp = JSONDeserializer<QueryGoodsResp>.deserializeFrom(json: json.description) {
                    if(resp.data != nil){
                        self.goodsList = resp.data ?? []
                    }
                }
            }
        }
    }
    
    func queryCategory() {
        LblProvider.request(.queryCategory) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let resp = JSONDeserializer<QueryCategroyResp>.deserializeFrom(json: json.description) {
                    if(resp.data != nil){
                        self.categoryList = resp.data ?? []
                    }
                }
            }
        }
    }
}

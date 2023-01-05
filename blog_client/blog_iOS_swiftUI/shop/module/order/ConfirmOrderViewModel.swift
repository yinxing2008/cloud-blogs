// 厦门大学计算机专业 | 前华为工程师
// 分享编程技术，没啥深度，但看得懂，适合初学者。
// Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import UIKit
import SwiftyJSON
import HandyJSON

class ConfirmOrderViewModel: ObservableObject {
    @Published var userAddr = UserAddr()
    @Published var createdOrderId: String = ""
    
    func queryData(callback: @escaping((UserAddr)->())) {
        LblProvider.request(.queryDefaultAddress) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let resp = JSONDeserializer<QueryAddrResp>.deserializeFrom(json: json.description) {
                    if let data = resp.data {
//                        self.userAddr = data
                        callback(data)
                    }
                }
            }
        }
    }

    func createOrder(cartItems: [CartItem], callback: @escaping((Bool,String,String)->())) {
        var createOrderReq = CreateOrderReq()
        createOrderReq.cartIdList = cartItems.map { $0.id }
        createOrderReq.userAddrId = userAddr.id

        LblProvider.request(.createFromCart(params: createOrderReq)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let resp = JSONDeserializer<CreateOrderResp>.deserializeFrom(json: json.description) {
                    if let data = resp.data {
                        callback(resp.isSuccess(),data.orderId, resp.msg)
                    }
                }
            }
        }
    }
}

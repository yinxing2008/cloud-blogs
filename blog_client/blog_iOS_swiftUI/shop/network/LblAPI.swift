// 厦门大学计算机专业 | 前华为工程师
// 分享编程技术，没啥深度，但看得懂，适合初学者。
// Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import Foundation
import Moya
import HandyJSON
import SwiftyJSON

let LblProvider = MoyaProvider<LblAPI>()


enum LblAPI {
    case login(params: [String:Any])
    case register(params: [String:Any])
    case queryCategory
    case queryGoodsByCategory(categoryId: String)
    case searchGoods(keyword: String)
    case queryCart
    case addToCart(goodsId: String)
    case queryAddress
    case queryDefaultAddress
    case deleteAddress(userAddrId: String)
    case addAddress(params: UserAddr)
    case modifyAddress(params: UserAddr)
    case queryOrderByStatus(orderStatus: Int)
    case queryOrder(orderId: String)
    case deleteOrder(orderId: String)
    case createFromCart(params: CreateOrderReq)
}

extension LblAPI: TargetType {
    public var baseURL: URL {
        //Moya会把path中带的问号转为%3F，所以只能将带有问号路径的URL放到baseURL中来规避该问题
        switch self {
            case .queryGoodsByCategory(let categoryId):
                return URL(string: "http://lblbc.cn/shop/goods?categoryId=\(categoryId)")!
            case .searchGoods(let keyword):
                return URL(string: "http://lblbc.cn/shop/goodsBySearch?keyword=\(keyword)")!
            case .deleteAddress(let userAddrId):
                return URL(string: "http://lblbc.cn/shop/addrs?addressId=\(userAddrId)")!
            case .queryOrderByStatus(let orderStatus):
                return URL(string: "http://lblbc.cn/shop/orders?orderStatus=\(orderStatus)")!
            default:
                return URL(string: "http://lblbc.cn/")!
        }
    }
    
    var path: String {
        switch self {
            case .login: return "user/login"
            case .register: return "user/register"
            case .queryCategory: return "shop/categories"
            case .queryCart: return "shop/cart"
            case .addToCart(let goodsId): return "shop/cart/add/"+goodsId
            case .queryAddress: return "shop/addrs"
            case .queryDefaultAddress: return "shop/addr_default"
            case .addAddress: return "shop/addrs"
            case .modifyAddress: return "shop/addrs"
            case .queryOrder(let orderId): return "shop/orders/\(orderId)"
            case .deleteOrder(let orderId): return "shop/orders/\(orderId)"
            case .createFromCart: return "shop/order/createFromCart"
            default: return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .queryCategory, .queryGoodsByCategory, .searchGoods, .queryCart, .queryAddress, .queryDefaultAddress, .addToCart, .queryOrderByStatus, .queryOrder:
            return .get
        case .login, .register, .addAddress, .createFromCart:
            return .post
        case .modifyAddress:
            return .put
        case .deleteAddress,.deleteOrder:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .createFromCart(let params):
            return .requestParameters(parameters: params.toJSON() ?? ["":""], encoding: JSONEncoding.default)
        case .addAddress(let params), .modifyAddress(let params):
            return .requestParameters(parameters: params.toJSON() ?? ["":""], encoding: JSONEncoding.default)
        case .login(let params), .register(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .queryCategory, .queryGoodsByCategory, .searchGoods, .queryCart, .queryAddress, .queryDefaultAddress, .addToCart, .deleteAddress, .queryOrderByStatus, .queryOrder, .deleteOrder:
            return .requestPlain
        }
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? {
        let userInfo = LoginViewModel.shared.userInfo
        var headerDict = ["Content-Type":"application/json;charset=utf-8"]
        if(userInfo != nil){
            headerDict["Authorization"] = userInfo!.token
        }
        return headerDict
    }
}

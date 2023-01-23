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
    case queryBlogList
    case queryBlog(blogId: Int)
    case deleteBlog(blogId: Int)
    case addBlog(params: Blog)
    case modifyBlog(params: Blog)
}

extension LblAPI: TargetType {
    public var baseURL: URL {
        //Moya会把path中带的问号转为%3F，所以只能将带有问号路径的URL放到baseURL中来规避该问题
        switch self {
            case .queryBlog(let blogId):
                return URL(string: "http://lblbc.cn/blog/blogs/\(blogId)")!
            case .deleteBlog(let blogId):
                return URL(string: "http://lblbc.cn/blog/blogs/\(blogId)")!
            default:
                return URL(string: "http://lblbc.cn/")!
        }
    }
    
    var path: String {
        switch self {
            case .login: return "user/login"
            case .register: return "user/register"
            case .queryBlogList: return "blog/blogs"
            case .addBlog: return "blog/blogs"
            case .modifyBlog: return "blog/blogs"
            default: return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .queryBlogList,.queryBlog:
            return .get
        case .login, .register, .addBlog:
            return .post
        case .modifyBlog:
            return .put
        case .deleteBlog:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .addBlog(let params), .modifyBlog(let params):
            return .requestParameters(parameters: params.toJSON() ?? ["":""], encoding: JSONEncoding.default)
        case .login(let params), .register(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .queryBlogList,.queryBlog, .deleteBlog:
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

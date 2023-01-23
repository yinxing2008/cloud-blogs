// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》  http://lblbc.cn/blog
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import UIKit
import SwiftyJSON
import HandyJSON

class BlogViewModel: ObservableObject {
    @Published var dataList:[Blog] = []
    @Published var blog:Blog = Blog()
    @Published var shouldRefresh = false
    
    func queryBlogList() {
        LblProvider.request(.queryBlogList) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let resp = JSONDeserializer<QueryBlogListResp>.deserializeFrom(json: json.description) {
                    if(resp.data != nil){
                        self.dataList = resp.data ?? []
                    }
                }
            }
        }
    }
    
    func queryBlog(blogId: Int) {
        LblProvider.request(.queryBlog(blogId: blogId)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let resp = JSONDeserializer<QueryBlogResp>.deserializeFrom(json: json.description) {
                    if(resp.data != nil){
                        self.blog = resp.data ?? Blog()
                    }
                }
            }
        }
    }
    
    func deleteBlog(blogId: Int, callback: @escaping((Bool,String)->())) {
        LblProvider.request(.deleteBlog(blogId: blogId)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let resp = JSONDeserializer<CommonResp>.deserializeFrom(json: json.description) {
                    self.queryBlogList()
                    callback(resp.isSuccess(),resp.msg)
                }
            }
        }
    }

    func addBlog(blog: Blog, callback: @escaping((Bool,String)->())) {
        LblProvider.request(.addBlog(params: blog)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let resp = JSONDeserializer<CommonResp>.deserializeFrom(json: json.description) {
                    callback(resp.isSuccess(),resp.msg)
                }
            }
        }
    }

    func modifyBlog(blog: Blog, callback: @escaping((Bool,String)->())) {
        LblProvider.request(.modifyBlog(params: blog)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let resp = JSONDeserializer<CommonResp>.deserializeFrom(json: json.description) {
                    callback(resp.isSuccess(),resp.msg)
                }
            }
        }
    }
}

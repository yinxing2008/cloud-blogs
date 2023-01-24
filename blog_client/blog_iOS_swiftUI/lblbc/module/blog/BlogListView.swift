// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》  http://lblbc.cn/blog
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI
import SDWebImageSwiftUI

struct BlogListView: View {
    @StateObject private var blogViewModel = BlogViewModel()
    @StateObject private var loginViewModel = LoginViewModel.shared
    @State var isLoggedIn: Bool = false
    @State var shouldShowLogin: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                Text("蓝不蓝博客")
                List {
                    ForEach(blogViewModel.dataList.indices , id: \.self){ i in
                        BlogRowView(viewModel: blogViewModel,
                                    blog: blogViewModel.dataList[i])
                    }
                }
                NavigationLink(destination: AddBlogView(viewModel: blogViewModel)){
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 60))
                }
            }.background(Color.white)
        }.onChange(of: loginViewModel.loginStatus, perform: { value in
            if(value) {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
            shouldShowLogin = !isLoggedIn
            blogViewModel.queryBlogList()
        }).onChange(of: blogViewModel.shouldRefresh, perform: { value in
            if(value) {
                blogViewModel.queryBlogList()
                blogViewModel.shouldRefresh = false
            }
        })
        
        .onAppear(perform: {
            isLoggedIn = loginViewModel.isLoggedIn()
            shouldShowLogin = !isLoggedIn
            blogViewModel.queryBlogList()
        }).sheet(isPresented: $shouldShowLogin, content: {
            LoginView(loginViewModel: loginViewModel)
        })
    }
}

struct BlogRowView: View {
    var viewModel: BlogViewModel
    var blog: Blog
    var body: some View {
        NavigationLink(destination: EditBlogView(blogId: blog.id, viewModel: viewModel)){
            Text(blog.title)
                .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
    }
}


struct BlogListView_Previews: PreviewProvider {
    static var previews: some View {
        BlogListView()
    }
}

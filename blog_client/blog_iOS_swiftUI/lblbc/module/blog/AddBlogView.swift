// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》  http://lblbc.cn/blog
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI

struct AddBlogView: View {
    var viewModel: BlogViewModel
    @State var blog = Blog()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            TextField("请输入标题", text: $blog.title)
            Divider()
            TextField("请输入内容", text: $blog.content)
        }
        .padding()
        .background(.white)
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        .background(Color(hex: 0xF4F4F4))
        .navigationBarItems(
            trailing:AddBlogTrailingButtons(onSave: {addBlog()}))
    }
    
    func addBlog() {
        viewModel.addBlog(blog: blog){isSuccess,msg in
            if(isSuccess){
                viewModel.shouldRefresh = true
                goBack()
            }else{
                // error = msg
            }
        }
    }
    
    private func goBack(){
        self.presentationMode.wrappedValue.dismiss()
    }
}
struct AddBlogTrailingButtons : View{
    var onSave: (()->())
    var body: some View {
        HStack{
            Button(action: {
                onSave()
            }) {
                Image(systemName: "tray")
            }
        }
    }
}

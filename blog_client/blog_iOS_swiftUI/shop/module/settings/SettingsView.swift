// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI

struct SettingsView: View {
    var refreshViewModel: RefreshViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            buildUserInfoWithAddr()
            buildAppInfo()
            Spacer()
            buildBottomBtn()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        .background(Color(hex: 0xF4F4F4))
    }
    
    private func buildUserInfoWithAddr() -> some View {
        return VStack{
            buildUserInfo()
            Divider()
            NavigationLink(destination: AddrListView()){
                HStack{
                    Text("收货地址").foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(Color(hex: 0x595D63))
                }.navigationBarTitle(Text(""), displayMode: .inline)
            }
        }
        .padding()
        .background(.white)
    }
    
    private func buildUserInfo() -> some View {
        return HStack{
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(Color.main_color)
                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 0))
            
            
            VStack{
                Text("尊贵会员").font(.title2)
                Text("级别：白银").foregroundColor(Color(hex: 0x9E9EA2))
            }
            Spacer()
            Text("查看个人资料").font(.body).foregroundColor(Color(hex: 0x595D63))
            Image(systemName: "chevron.right").foregroundColor(Color(hex: 0x595D63))
        }
    }
    
    private func buildAppInfo() -> some View {
        return VStack{
            HStack{
                Text("隐私设置")
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(Color(hex: 0x595D63))
            }
            Divider()
            HStack{
                Text("APP版本")
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(Color(hex: 0x595D63))
            }
            Divider()
            HStack{
                Text("隐私政策")
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(Color(hex: 0x595D63))
            }
            Divider()
            HStack{
                Text("关于")
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(Color(hex: 0x595D63))
            }
        }
        .padding()
        .background(.white)
    }
    
    private func buildBottomBtn() -> some View {
        return Button(action:{ quitLogin()}){
            Text("退出登录")
                .padding()
                .frame(maxWidth:.infinity)
                .background(.white)
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 20, trailing: 0))
        }
    }
    
    func quitLogin() {
        LoginViewModel.shared.quitLogin()
        refreshViewModel.shouldRefresh = true
        goBack()
    }
    
    private func goBack(){
        self.presentationMode.wrappedValue.dismiss()
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(refreshViewModel: RefreshViewModel())
    }
}

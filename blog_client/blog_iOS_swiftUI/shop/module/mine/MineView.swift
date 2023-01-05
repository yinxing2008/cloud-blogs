// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI

struct MineView: View {
    @State var isLoggedIn: Bool = false
    @StateObject private var refreshViewModel = RefreshViewModel()
    
    var body: some View {
        VStack{
            buildSettingsInfo()
            buildUserInfo()
            buildOrderInfo()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(hex: 0xF4F4F4))
        .onChange(of: refreshViewModel.shouldRefresh, perform: { value in
            refreshViewModel.shouldRefresh = false
            if(value) {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        }).onAppear(perform: {
            isLoggedIn = LoginViewModel.shared.isLoggedIn()
        })
    }
    
    private func buildSettingsInfo() -> some View{
        HStack{
            NavigationLink(destination: SettingsView(refreshViewModel: refreshViewModel)) {
                Image("settings")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
            }.navigationBarTitle(Text(""), displayMode: .inline)
        }.frame(maxWidth: .infinity,alignment: .trailing)
    }
    
    private func buildUserInfo() -> some View{
        return HStack{
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(Color.main_color)
                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 0))
            VStack{
                if isLoggedIn {
                    Text("尊贵会员").font(.title3)
                } else {
                    NavigationLink(destination: LoginView(refreshViewModel: refreshViewModel)) {
                        Text("登录/注册 >").font(.title3).foregroundColor(.black)
                    }.navigationBarTitle(Text(""), displayMode: .inline)
                }
                
                Text("级别：白银")
                    .padding(EdgeInsets.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                    .background(Color(hex: 0xD3D3F7))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            Spacer()
        }
    }
    
    private func buildOrderInfo() -> some View{
        return  VStack{
            HStack{
                Text("我的订单").font(.title3)
                Spacer()
                
                NavigationLink(destination: buildLoginViewOrOrderView()) {
                    Text("全部订单").font(.body).foregroundColor(Color(hex: 0x595D63))
                    Image(systemName: "chevron.right").foregroundColor(Color(hex: 0x595D63))
                }
                
            }
            HStack{
                NavigationLink(destination: OrderListView()) {
                    VStack{
                        Image("to_pay").resizable().frame(width: 40, height: 40)
                        Text("待付款").font(.body).foregroundColor(Color(hex: 0x595D63))
                    }
                }
                Spacer()
                NavigationLink(destination: OrderListView()) {
                    VStack{
                        Image("to_deliver").resizable().frame(width: 40, height: 40)
                        Text("待发货").font(.body).foregroundColor(Color(hex: 0x595D63))
                    }
                }
                Spacer()
                NavigationLink(destination: OrderListView()) {
                    VStack{
                        Image("to_receive").resizable().frame(width: 40, height: 40)
                        Text("待收货").font(.body).foregroundColor(Color(hex: 0x595D63))
                    }
                }
                Spacer()
                NavigationLink(destination: OrderListView()) {
                    VStack{
                        Image("to_comment").resizable().frame(width: 40, height: 40)
                        Text("待评价").font(.body).foregroundColor(Color(hex: 0x595D63))
                    }
                }
                Spacer()
                NavigationLink(destination: OrderListView()) {
                    VStack{
                        Image("to_return").resizable().frame(width: 40, height: 40)
                        Text("退换/售后").font(.body).foregroundColor(Color(hex: 0x595D63))
                    }
                }
            }
        }.padding(EdgeInsets.init(top: 20, leading: 10, bottom: 10, trailing: 10))
            .frame(maxWidth: .infinity,alignment: .leading)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding()
    }
    
    private func buildLoginViewOrOrderView() -> some View{
        return HStack{
            if isLoggedIn {
                OrderListView()
            }else {
                LoginView(refreshViewModel: refreshViewModel)
            }
        }
    }
    
}

struct MineView_Previews: PreviewProvider {
    static var previews: some View {
        MineView()
    }
}

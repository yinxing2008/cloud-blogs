// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI
import SDWebImageSwiftUI

struct AddrListView: View {
    @StateObject private var viewModel = AddrViewModel()
    @StateObject private var refreshViewModel = RefreshViewModel()
    
    var body: some View {
        VStack{
            List {
                ForEach(viewModel.dataList.indices , id: \.self){ i in
                    AddrItemView(viewModel: viewModel,
                                 refreshViewModel: refreshViewModel,
                                 userAddr: viewModel.dataList[i])
                }
            }
            NavigationLink(destination: AddAddrView(viewModel: viewModel, refreshViewModel: refreshViewModel))
            {
                Text("添加收货地址").font(.headline).frame(maxWidth:.infinity)
                    .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .foregroundColor(.white)
                    .background(Color.main_color)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(EdgeInsets.init(top: 2, leading: 10, bottom: 5, trailing: 10))
            }
            
        }.onAppear(perform: {
            viewModel.queryData()
        })
    }
}

struct AddrItemView: View {
    var viewModel: AddrViewModel
    var refreshViewModel: RefreshViewModel
    var userAddr: UserAddr
    var body: some View {
        VStack{
            HStack{
                Text(userAddr.name)
                Text(userAddr.phone).foregroundColor(Color.gray)
                if userAddr.defaultAddress {
                    Text("默认").foregroundColor(.white)
                        .frame(width:50, height: 30)
                        .background(RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(Color(hex: 0x8298bd)))
                }
                
                Spacer()
            }
            HStack{
                Text(userAddr.address)
                Spacer()
            }
            HStack{
                Spacer()
                Text("删除").frame(width:60, height: 30)
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.gray,lineWidth: 1))
                    .foregroundColor(Color(hex: 0x141414))
                    .onTapGesture(perform: {
                        viewModel.deleteAddress(userAddrId: userAddr.id)
                    })
                Text("编辑").frame(width:60, height: 30)
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.gray,lineWidth: 1))
                    .background(NavigationLink("", destination: EditAddrView(viewModel: viewModel, refreshViewModel: refreshViewModel, userAddr: userAddr)).opacity(0) )
            }
        }.padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

struct AddrListView_Previews: PreviewProvider {
    static var previews: some View {
        AddrListView()
    }
}

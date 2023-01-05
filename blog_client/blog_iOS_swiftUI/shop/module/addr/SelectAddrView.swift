// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI
import SDWebImageSwiftUI


class SharedViewModel: ObservableObject {
    @Published var addrId = ""
    @Published var address = ""
    @Published var addrName = ""
}


struct SelectAddrView: View {
    @ObservedObject var sharedViewModel : SharedViewModel
    @StateObject private var viewModel = AddrViewModel()
    @StateObject private var refreshViewModel = RefreshViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            List {
                ForEach(viewModel.dataList.indices , id: \.self){ i in
                    SelectAddrItemView(presentationMode: presentationMode,
                                       viewModel: viewModel,
                                       refreshViewModel: refreshViewModel,
                                       userAddr: viewModel.dataList[i],
                                       sharedViewModel: sharedViewModel)
                }
            }
            NavigationLink(destination: AddAddrView(viewModel: viewModel, refreshViewModel: refreshViewModel)){
                Text("添加收货地址").font(.headline).frame(maxWidth:.infinity)
                    .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .foregroundColor(.white)
                    .background(Color.main_color)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(EdgeInsets.init(top: 2, leading: 10, bottom: 5, trailing: 10))
            }
            
        }.onAppear(perform: {
            viewModel.queryData()
            sharedViewModel.addrName = "3333"
        })
    }
}

struct SelectAddrItemView: View {
    @Binding var presentationMode: PresentationMode
    var viewModel: AddrViewModel
    var refreshViewModel: RefreshViewModel
    var userAddr: UserAddr
    var xxID = ""
    @State private var isShowingDetailView = false
    @ObservedObject var sharedViewModel : SharedViewModel
    var body: some View {
        HStack{
            SimpleRadioButton(id: userAddr.id, selectedID: sharedViewModel.addrId, callBack: self.radioButtonCallBack)
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
            }
        }
    }
    
    private func radioButtonCallBack(id: String) {
        sharedViewModel.addrId = self.userAddr.id
        sharedViewModel.addrName = self.userAddr.name
        sharedViewModel.address = self.userAddr.address
        goBack()
    }
    
    private func goBack(){
        presentationMode.dismiss()
    }
}

//struct SelectAddrView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectAddrView()
//    }
//}

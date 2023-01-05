// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @StateObject private var viewModel = CartViewModel()
    private var selectedCartItems:[CartItem]{//通过计算属性获取选中商品总数
        get {
            viewModel.dataList.filter(){return $0.isSelected == true}
        }
    }
    private var selectedCount:Int{//通过计算属性获取选中商品总数
        get {selectedCartItems.count}
    }
    
    private var selectedSum:Int{//通过计算属性获取选中商品金额总和
        get {
            viewModel.dataList
                .filter(){return $0.isSelected == true}
                .map({
                    return $0.price*$0.quantity
                })
                .reduce(0,{return $0+$1})/100
        }
    }
    
    var body: some View {
        VStack{
            List {
                ForEach(viewModel.dataList.indices , id: \.self){ i in
                    CartItemView(cartItem: $viewModel.dataList[i])
                }
            }
            Spacer()
            HStack{
                Spacer()
                Text("已选 (\(selectedCount))")
                Spacer()
                Text("总计")
                Text("￥\(selectedSum)")
                Spacer()
//                NavigationLink(destination: ConfirmOrderFromCartView(costSum: selectedSum, cartItems: selectedCartItems)){
//                    Text("结算").font(.headline).frame(minWidth: 150)
//                        .padding(EdgeInsets.init(top: 5, leading: 0, bottom: 5, trailing: 0))
//                        .foregroundColor(.white)
//                        .background(selectedCount>0 ? Color.main_color : Color.gray)
//                        .clipShape(RoundedRectangle(cornerRadius: 5))
//                }
                
                Spacer()
            } .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 5, trailing: 0))
        }.onAppear(perform: {
            viewModel.queryData()
        })
    }
}

struct CartItemView: View {
    @Binding var cartItem: CartItem
    var body: some View {
        HStack{
            Toggle("", isOn: $cartItem.isSelected)
                .toggleStyle(CheckBoxToggleStyle(shape: .square))
            WebImage(url: URL(string: cartItem.squarePic ?? ""))
                .placeholder{Color.gray}
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text(cartItem.name).lineLimit(3)
        }
        
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

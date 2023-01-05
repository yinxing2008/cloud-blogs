// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI
import SDWebImageSwiftUI

struct OrderDetailView: View {
    var orderInfo: OrderInfo?
    var orderId: String
    @StateObject private var viewModel = OrderDetailViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            if let orderInfo = viewModel.orderInfo {
                buildOrderItemView(orderInfo: orderInfo)
                buildInvoiceView()
                buildOrderExtraView(orderInfo: orderInfo)
                Spacer()
                buildBottomView(orderInfo: orderInfo)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        .background(Color(hex: 0xF4F4F4))
        .overlay(//添加悬浮图标
            VStack{
                Image(systemName: "mic")
                Text("客服").font(.system(size:12))
            }
                .padding()
                .foregroundColor(.white)
                .background(Color(hex: 0x8298BD))
                .clipShape(Circle())
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 40, trailing: 10))
            ,alignment: .bottomTrailing)
        .onAppear(perform: {
            viewModel.queryOrder(orderId: orderId)
        })
    }
    
    private func buildOrderItemView(orderInfo: OrderInfo) -> some View{
        return VStack{
            VStack{
                HStack{
                    Text("X商自营").font(.title3)
                    Image(systemName: "chevron.right").foregroundColor(Color(hex: 0x595D63))
                    Spacer()
                    Text("状态").foregroundColor(.gray)
                }
                
                buildOrderListView(list: orderInfo.list)
                
                Divider()
                HStack{
                    Text("商品总金额")
                    Spacer()
                    //                    Text("￥\(orderDetail.price*orderDetail.quantity/100)")
                }.padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                HStack{
                    Text("运费")
                    Spacer()
                    Text("￥0.00")
                }.padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                //                Text("实付￥\(orderDetail.price*orderDetail.quantity/100)").font(.title3)
            }.padding(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 0, trailing: 10))
        }
    }
    
    private func buildInvoiceView() -> some View{
        VStack(alignment: .leading){
            HStack{
                Text("发票信息")
                Spacer()
                Text("查看发票").foregroundColor(Color(hex: 0x565D66))
                Image(systemName: "chevron.right").foregroundColor(Color(hex: 0x565D66))
            }
            HStack{
                Text("发票类型").foregroundColor(Color(hex: 0x97999E))
                Text("电子发票").foregroundColor(Color(hex: 0x595D63))
            }.padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 0))
            HStack{
                Text("发票抬头").foregroundColor(Color(hex: 0x97999E))
                Text("X先生").foregroundColor(Color(hex: 0x595D63))
            }.padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 0))
            HStack{
                Text("发票内容").foregroundColor(Color(hex: 0x97999E))
                Text("商品明细").foregroundColor(Color(hex: 0x595D63))
            }.padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 0))
        }.padding(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            .frame(maxWidth: .infinity,alignment: .leading)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
    
    private func buildOrderExtraView(orderInfo: OrderInfo) -> some View{
        VStack(alignment: .leading){
            Text("订单信息")
            HStack{
                let userAddr = orderInfo.userAddr
                let name = userAddr?.name ?? ""
                let phone = userAddr?.phone ?? ""
                let address = userAddr?.address ?? ""
                Text("收货信息").foregroundColor(Color(hex: 0x97999E))
                Text(name+"，"+phone+"，"+address).foregroundColor(Color(hex: 0x595D63))
            }.padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 0))
            HStack{
                Text("订单编号").foregroundColor(Color(hex: 0x97999E))
                Text("\(orderInfo.orderId)").foregroundColor(Color(hex: 0x595D63)).font(.system(size:14))
            }.padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 0))
            HStack{
                Text("下单时间").foregroundColor(Color(hex: 0x97999E))
                
            }.padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 0))
        }.padding(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            .frame(maxWidth: .infinity,alignment: .leading)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
    
    private func buildBottomView(orderInfo: OrderInfo) -> some View{
        return VStack{
            Divider()
            HStack{
                Spacer()
                Text("删除订单").padding(EdgeInsets.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.gray,lineWidth: 1))
                    .foregroundColor(Color(hex: 0x141414))
                    .onTapGesture(perform: {
                        viewModel.deleteOrder(orderId: orderInfo.orderId){ isSuccess,msg in
                            goBack()
                        }
                    })
                Text("申请售后").padding(EdgeInsets.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.gray,lineWidth: 1))
                    .foregroundColor(Color(hex: 0x141414))
                    .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 10))
            }
        }.background(.white)
    }
    
    private func buildOrderListView(list: [OrderDetail]) -> some View{
        return VStack{
            ForEach(list.indices , id: \.self){ j in
                let orderDetail = list[j]
                HStack{
                    WebImage(url: URL(string: orderDetail.squarePic ?? ""))
                        .placeholder{Color.gray}
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading){
                        Text(orderDetail.name).padding(EdgeInsets.init(top: 0, leading: 0, bottom: 5, trailing: 0))
                        HStack{
                            Text("7天无理由退货")
                                .font(.system(size:12))
                                .foregroundColor(Color(hex: 0x677DA5))
                                .padding(EdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 5))
                                .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color(hex: 0xEAF3FF)))
                            Text("不支持换货")
                                .font(.system(size:12))
                                .foregroundColor(Color(hex: 0x97999E))
                                .padding(EdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 5))
                                .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color(hex: 0xF2F5F5)))
                        }
                    }
                    VStack{
                        Text("￥\(orderDetail.price/100)")
                        Text("×\(orderDetail.quantity)")
                    }
                }
            }
        }
    }
    
    private func goBack(){
        self.presentationMode.wrappedValue.dismiss()
    }
}


//struct OrderDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderDetailView()
//    }
//}

// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    @State var imageIndex: Int = 0
    
    var body: some View {
        VStack{
            List {
                LblBanner(goodsList: homeViewModel.dataListForBanner, height: 200, width: 330, index: $imageIndex)
                
                ForEach(homeViewModel.dataList.indices , id: \.self){ i in
                    NavigationLink(destination: GoodsView(goods: homeViewModel.dataList[i])) {
                        GoodsItemView(goods: homeViewModel.dataList[i])
                    }
                }
            }
        }
        .navigationBarTitle(Text("X商城"), displayMode: .inline)
        .navigationBarItems(trailing:NavigationLink(destination: SearchView()) {
            Image(systemName: "magnifyingglass")
        })
        .onAppear(perform: {
            homeViewModel.queryData()
        })
        
    }
}

struct GoodsItemView: View {
    var goods: Goods
    var body: some View {
        HStack{
            WebImage(url: URL(string: goods.squarePic ?? ""))
                .placeholder{Color.gray}
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text(goods.name).lineLimit(3)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

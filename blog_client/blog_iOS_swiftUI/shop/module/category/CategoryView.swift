// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI
import SDWebImageSwiftUI

struct CategoryView: View {
    @StateObject private var viewModel = CategoryViewModel()
    @State var selectedIndex = 0
    
    var body: some View {
        VStack{
            if viewModel.categoryList.count > 0 {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<viewModel.categoryList.count) { i in
                            TabItemView(i)
                        }
                    }
                }.padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                CategoryPageView(viewModel: viewModel, selectedIndex: $selectedIndex)
                    .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 1, trailing: 0))
            }
        }.navigationBarTitle(Text("X商城"), displayMode: .inline)
            .navigationBarItems(trailing:NavigationLink(destination: SearchView()) {
                Image(systemName: "magnifyingglass")
            })
            .onAppear(perform: {
                viewModel.queryCategory()
            })
    }
    
    private func TabItemView(_ i: Int) -> some View {
        return VStack{
            Text(viewModel.categoryList[i].name)
                .foregroundColor(selectedIndex == i ? Color.main_color : .gray)
                .padding(EdgeInsets.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                .onTapGesture(perform: {
                    selectedIndex = i
                })
            Divider().frame(height: 2).background(selectedIndex == i ? Color.main_color : .white)
        }
    }
}

struct CategoryPageView: View {
    @StateObject var viewModel: CategoryViewModel
    @Binding var selectedIndex: Int
    
    var body: some View {
        List {
            ForEach(viewModel.goodsList , id: \.self){ goods in
                NavigationLink(destination: GoodsView(goods:goods)) {
                    GoodsItemView(goods: goods)
                }
            }
        }.onChange(of: selectedIndex) {
            print(String(viewModel.goodsList.count))
            viewModel.queryGoodsByCategory(categoryId: viewModel.categoryList[$0].id)
        }.onAppear(perform: {
            viewModel.queryGoodsByCategory(categoryId: viewModel.categoryList[selectedIndex].id)
        })
    }
}


struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}

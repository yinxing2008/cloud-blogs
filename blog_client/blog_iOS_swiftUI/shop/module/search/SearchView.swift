// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI

struct SearchView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    @State private var searchText : String = ""
    
    var body: some View {
        SearchBar(text: $searchText){
            searchViewModel.queryData(keyword: searchText)
        }
        
        List {
            ForEach(searchViewModel.dataList.indices , id: \.self){ i in
                NavigationLink(destination: GoodsView(goods: searchViewModel.dataList[i])) {
                    GoodsItemView(goods: searchViewModel.dataList[i])
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI

struct SimpleRadioButton: View {
    let id: String
    let selectedID: String
    let callBack: (String) -> ()

    init(id: String, selectedID: String, callBack: @escaping (String) -> ()){
        self.id = id
        self.selectedID = selectedID
        self.callBack = callBack
    }
    
    var body: some View {
        Button(action: {
            self.callBack(self.id)
        }, label: {
            HStack(alignment: .center, spacing: 12, content: {
                Image(systemName: self.selectedID == self.id ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(self.selectedID == self.id ? Color.blue : Color.black)
            })
        })
    }
}

// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI


public struct RadioGroup: View {
    @Binding var value: Int
    @State var options: [RadioOption]
    @State var selectedIdx: Int = -1
    var color: Color = Color(.sRGB, red: 50/255, green: 200/255, blue: 165/255)
    
    public var body: some View {
        HStack{
            ForEach(0..<options.count, id: \.self) { idx in
                RadioButton(selectedIdx: self.$selectedIdx, idx: idx, option: options[idx], value: $value, color: color)
            }
        }.onAppear(perform: {
            for i in 0..<options.count {
                if options[i].value == $value.wrappedValue {
                    self.selectedIdx = i
                }
            }
        })
    }
}

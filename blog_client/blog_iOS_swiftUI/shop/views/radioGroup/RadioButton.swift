// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI

struct RadioButton: View {
    @Binding var value: Int
    @State var idx: Int
    @Binding var selectedIdx: Int
    var option: RadioOption
    var size: CGFloat = 24
    var color: Color
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .strokeBorder(Color.gray,lineWidth: 1)
                    .frame(width: size, height: size)
                Circle()
                    .fill(color)
                    .frame(width: selectedIdx == idx ? size-8 : 0, height: selectedIdx == idx ? size-8 : 0)
            }
            Text("\(option.label)").font(Font.system(size: 17, weight: .light, design: .rounded))
        }.contentShape(Rectangle())
        .onTapGesture {
            self.value = option.value
            withAnimation(.spring()) {
                self.selectedIdx = idx
            }
        }
    }
    
    init(selectedIdx: Binding<Int>, idx: Int, option: RadioOption, value: Binding<Int>, color: Color) {
        self._selectedIdx = selectedIdx
        self._idx = .init(initialValue: idx)
        self.option = option
        self._value = value
        self.color = color
    }
}

public struct RadioOption {
    var label: String = ""
    var value: Int
    
    public init(label: String, value: Int) {
        self.label = label
        self.value = value
    }
}

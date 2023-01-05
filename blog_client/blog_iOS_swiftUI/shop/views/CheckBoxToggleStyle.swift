// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI

struct CheckBoxToggleStyle: ToggleStyle{
    enum CheckBoxShape: String{
        case circle
        case square
    }
    let shape : CheckBoxShape
    init(shape: CheckBoxShape = .circle){
        self.shape = shape
    }
    //configuration中包含isOn和label
    func makeBody(configuration: Configuration) -> some View {
        let systemName:String = configuration.isOn ? "checkmark.\(shape.rawValue).fill" : shape.rawValue
        Button(action: {
            configuration.isOn.toggle()
        }) {
            configuration.label
            Image(systemName: systemName)
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
}

// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》  http://lblbc.cn/blog
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import Foundation
import SwiftUI

extension Color {
    init(hex: Int, alpha: Double = 1) {
           let components = (
               R: Double((hex >> 16) & 0xff) / 255,
               G: Double((hex >> 08) & 0xff) / 255,
               B: Double((hex >> 00) & 0xff) / 255
           )
           self.init(
               .sRGB,
               red: components.R,
               green: components.G,
               blue: components.B,
               opacity: alpha
           )
       }
    
    public static var main_color: Color {
        Color("main_color", bundle: nil)
    }
    
    static var tsmg_systemBackground: Color {
        Color(UIColor.systemBackground)
    }
    
    static var tsmg_secondarySystemBackground: Color {
        Color(UIColor.secondarySystemBackground)
    }
    
    static var tsmg_tertiarySystemBackground: Color {
        Color(UIColor.tertiarySystemBackground)
    }
    
    
    static var tsmg_systemGroupedBackground: Color {
        Color(UIColor.systemGroupedBackground)
    }
    
    static var tsmg_secondarySystemGroupedBackground: Color {
        Color(UIColor.secondarySystemGroupedBackground)
    }
    
    static var tsmg_tertiarySystemGroupedBackground: Color {
        Color(UIColor.tertiarySystemGroupedBackground)
    }
    
    static var tsmg_label: Color {
        Color(UIColor.label)
    }
    
    static var tsmg_secondaryLabel: Color {
        Color(UIColor.secondaryLabel)
    }
    
    static var tsmg_tertiaryLabel: Color {
        Color(UIColor.tertiaryLabel)
    }
    
    static var tsmg_placeholderText: Color {
        Color(UIColor.placeholderText)
    }
}



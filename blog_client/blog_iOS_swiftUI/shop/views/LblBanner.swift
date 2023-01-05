// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI
import SDWebImageSwiftUI

struct LblBanner: View {
    private var goodsList: [Goods]
    private var height: CGFloat
    private var width: CGFloat
    private let threshold: CGFloat = 120
    
    @Binding private var now_img_index: Int
    @State private var local_x_offset: CGFloat = .zero
    
    private var total_x_offset: CGFloat {
        -CGFloat(now_img_index) * width + local_x_offset
    }
    
    private var last_index: Int {
        goodsList.count>0 ? goodsList.count - 1 : 0
    }
    private var pre_index: Int {
        now_img_index == 0 ? last_index : now_img_index - 1
    }
    private var next_index: Int {
        now_img_index == last_index ? 0 : now_img_index + 1
    }
    
    private var points: some View {
        HStack(spacing: 5) {
            ForEach(0...last_index, id: \.self) { index in
                Circle()
                    .fill(index == now_img_index ? Color.red : Color.white)
                    .frame(width: 5, height: 5)
            }
        }
    }
    
    private var lunbo_drag_gesture: some Gesture {
        DragGesture()
            .onChanged {value in
                local_x_offset = value.translation.width
            }
            .onEnded { value in
                if value.translation.width > threshold {   // 右滑
                    now_img_index = pre_index
                }
                if value.translation.width < -threshold { // 左滑
                    now_img_index = next_index
                }
                local_x_offset = 0
            }
    }
    
    init(goodsList: [Goods], height: CGFloat, width: CGFloat, index: Binding<Int>) {
        self.goodsList = goodsList
        self.height = height
        self.width = width
        self._now_img_index = index
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            HStack(spacing: 0) {
                ForEach(goodsList.indices, id: \.self) { index in
                    NavigationLink(destination: GoodsView(goods: goodsList[index])) {
                        WebImage(url: URL(string: goodsList[index].longPic ?? ""))
                            .placeholder{Color.gray}
                            .resizable()
                            .scaledToFit()
                            .frame(width: width, height: height)
                    }
                }
            }
            .offset(x: total_x_offset)
            .gesture( lunbo_drag_gesture )
            .frame(width: width, height: height, alignment: .leading)
            
            points
                .padding(.bottom, 10)
                .padding(.trailing, 30)
        }
    }
}

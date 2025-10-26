//
//  SideMenuView.swift
//  Zero
//
//  Created by 强风吹拂 on 2025/10/26.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        // ZStack 让背景色可以忽略安全区域
        ZStack {
            // 侧边栏的背景色
            Color(UIColor.systemGray6)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 20) {
                // 为了让内容不被顶部的状态栏遮挡，加一点顶部间距
                Spacer()
                    .frame(height: 60)
                
                // --- 侧边栏内容 ---
                Text("菜单项 1")
                    .font(.headline)
                
                Text("菜单项 2")
                    .font(.headline)
                
                Text("设置")
                    .font(.headline)
                
                Divider() // 分割线
                
                Text("关于")
                    .font(.headline)
                // --- 内容结束 ---
                
                Spacer() // 将所有内容推到顶部
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// 预览提供程序，方便你单独调试侧边栏UI
struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}



//
//  SearchView.swift
//  Zero
//
//  Created by 强风吹拂 on 2025/10/26.
//

import SwiftUI

struct SearchView: View {
    // 1. 添加一个状态来保存搜索文本
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            // 2. 添加一个搜索框
            // .searchable() 是更现代的方式，但为了与你的 NavigationView 结构兼容，
            // 我们这里先用一个简单的 TextField
            TextField("搜索笔记...", text: $searchText)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            // 3. (可选) 显示搜索结果
            // 目前只是一个占位符
            List {
                Text("搜索结果 1")
                Text("搜索结果 2")
            }
            .listStyle(PlainListStyle())

            Spacer()
        }
        .padding(.top, 16) // 顶部留出一些空间
        .navigationTitle("搜索") // 设置此页面的导航栏标题
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline) // 保持标题栏样式一致
        #endif
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        // 为了让预览正常工作，把它包在一个 NavigationView 中
        NavigationView {
            SearchView()
        }
    }
}

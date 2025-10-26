//
//  CardView.swift
//  Zero
//
//  Created by 强风吹拂 on 2025/10/26.
//
import SwiftUI

struct CardView: View {
    let id: UUID // 为每个卡片添加一个唯一标识符
    let date: String
    let weatherIcon: String
    let weatherText: String
    let onDelete: (UUID) -> Void // 添加一个删除回调闭包

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 日期
            Text(date)
                .font(.caption)
                .foregroundColor(.gray)

            // 天气和文本
            HStack(spacing: 12) {
                // 天气图标
                Image(systemName: weatherIcon) // 使用外部传入的图标
                    .renderingMode(.original)
                    .font(.system(size: 24))
                    .frame(width: 40, height: 40)
                    .background(Color.blue.opacity(0.7))
                    .clipShape(Circle())
                
                // 文本
                Text(weatherText) // 使用外部传入的文本
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            // 右下角文本 - 删除按钮
            HStack {
                Spacer()
                Button(action: {
                    onDelete(id) // 调用传入的删除回调，并传递当前卡片的ID
                }) {
                    Text("删除")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

// CardView 的预览现在需要传入示例数据
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(id: UUID(), date: "2025-07-26", weatherIcon: "cloud.sun.fill", weatherText: "今天天气不错", onDelete: { _ in })
            .previewLayout(.sizeThatFits) // 预览时让视图适应内容大小
            .padding()
    }
}

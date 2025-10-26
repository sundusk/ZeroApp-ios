import SwiftUI

// CardItem 结构体... (不变)
struct CardItem: Identifiable, Equatable {
    let id = UUID()
    var date: String
    var weatherIcon: String
    var weatherText: String
}

struct ContentView: View {
    
    @State private var isMenuOpen = false
    @State private var cardItems: [CardItem] = []
    @State private var isShowingSearch = false
    
    var body: some View {
        // GeometryReader 和 ZStack ... (不变)
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                navigationViewContent(geometry: geometry)
                    .offset(x: isMenuOpen ? (geometry.size.width * 0.75) : 0)
                    .disabled(isMenuOpen)
                
                if isMenuOpen {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isMenuOpen = false
                            }
                        }
                        .offset(x: isMenuOpen ? (geometry.size.width * 0.75) : 0)
                }

                SideMenuView()
                    .frame(width: geometry.size.width * 0.75)
                    .offset(x: isMenuOpen ? 0 : -(geometry.size.width * 0.75))
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    // 主内容的 NavigationView
    private func navigationViewContent(geometry: GeometryProxy) -> some View {
        // --- 1. 修改：将 NavigationView 替换为 NavigationStack ---
        NavigationStack {
            ZStack {
                Color(red: 242/255, green: 242/255, blue: 247/255)
                    .edgesIgnoringSafeArea(.all)
                
                // --- 2. 删除：不再需要隐藏的 NavigationLink ---
                // NavigationLink(
                //     destination: SearchView(),
                //     isActive: $isShowingSearch,
                //     label: { EmptyView() }
                // )

                VStack {
                    Spacer().frame(height: 16)
                    
                    if cardItems.isEmpty {
                        // 空状态视图 (不变)
                        VStack(spacing: 20) {
                            Image(systemName: "note.text")
                                .font(.system(size: 80))
                                .foregroundColor(.gray)
                            
                            Text("暂无笔记，快去添加一条吧！")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        // 列表视图 (不变)
                        ScrollView {
                            ForEach(cardItems) { item in
                                CardView(
                                    id: item.id,
                                    date: item.date,
                                    weatherIcon: item.weatherIcon,
                                    weatherText: item.weatherText,
                                    onDelete: deleteCard
                                )
                                .padding(.vertical, 8)
                            }
                            Spacer().frame(height: 100)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)

                // 浮动添加按钮 (不变)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { addCard() }) {
                            Image(systemName: "plus")
                                .font(.system(size: 28, weight: .regular))
                                .padding(20)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.bottom, 30)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Zero")
            
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // 侧边栏按钮 (不变)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            isMenuOpen.toggle()
                        }
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.primary)
                    }
                }
                
                // 搜索按钮 (不变, action 逻辑依然有效)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingSearch = true // 这个 action 现在会触发 .navigationDestination
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                    }
                }
            }
            #endif
            
            // --- 3. 新增：使用新的 .navigationDestination 修饰符 ---
            // 这个修饰符会监听 $isShowingSearch 的变化
            .navigationDestination(isPresented: $isShowingSearch) {
                SearchView()
            }
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
    }
    
    // addCard() 和 deleteCard() 方法 ... (不变)
    
    private func addCard() {
        let newCard = CardItem(
            date: Date().formatted(date: .long, time: .shortened),
            weatherIcon: ["sun.max.fill", "cloud.fill", "cloud.rain.fill", "snowflake"].randomElement() ?? "questionmark.circle.fill",
            weatherText: ["今天天气真好！", "有点阴天，记得带伞。", "下雨了，注意保暖。", "雪花飘飘，好冷啊！", "今天天气不错"].randomElement() ?? "天气未知"
        )
        withAnimation {
            cardItems.append(newCard)
        }
    }
    
    private func deleteCard(id: UUID) {
        withAnimation {
            cardItems.removeAll { $0.id == id }
        }
    }
}

// Previews (不变)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import SwiftUI

enum Tab: String, CaseIterable, Identifiable {
    case home = "首页"
    case settings = "设置"
    case profile = "个人"
    case help = "帮助"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .settings: return "gearshape.fill"
        case .profile: return "person.fill"
        case .help: return "questionmark.circle.fill"
        }
    }
}

struct ContentView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        VStack(spacing: 0) {
            // Tab 按钮栏
            HStack(spacing: 0) {
                ForEach(Tab.allCases) { tab in
                    tabButton(tab)
                }
            }
            .padding(.horizontal)
            .background(Color(nsColor: .windowBackgroundColor))

            Divider()

            // Tab 内容区
            TabContentView(selectedTab: selectedTab)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func tabButton(_ tab: Tab) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(.system(size: 18))
                Text(tab.rawValue)
                    .font(.caption)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .foregroundColor(selectedTab == tab ? .blue : .secondary)
            .background(
                selectedTab == tab ?
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.blue.opacity(0.1)) : nil
            )
        }
        .buttonStyle(.plain)
    }
}

struct TabContentView: View {
    let selectedTab: Tab

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: selectedTab.icon)
                .font(.system(size: 60))
                .foregroundColor(.blue)

            Text(selectedTab.rawValue)
                .font(.largeTitle)

            Text("这是 \(selectedTab.rawValue) 标签页的内容")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

# SwiftUI macOS Tab 页面

## 简介

演示如何在 SwiftUI 中实现自定义 Tab 页面切换效果。SwiftUI 没有内置的 TabView 组件（iOS 有），所以需要自己实现。

## 快速开始

```bash
cd swiftui-macos-tabview-demo
xcodegen generate
open SwiftUITabViewDemo.xcodeproj
# Cmd+R 运行
```

## 概念讲解

### 定义 Tab 枚举

```swift
enum Tab: String, CaseIterable, Identifiable {
    case home = "首页"
    case settings = "设置"
    case profile = "个人"

    var id: String { rawValue }
}
```

### 使用 ForEach 渲染 Tab 按钮

```swift
ForEach(Tab.allCases) { tab in
    Button {
        selectedTab = tab
    } label: {
        VStack {
            Image(systemName: tab.icon)
            Text(tab.rawValue)
        }
    }
    .buttonStyle(.plain)
}
```

### 切换动画

```swift
Button {
    withAnimation(.easeInOut(duration: 0.2)) {
        selectedTab = tab
    }
}
```

### 根据选中状态显示不同内容

```swift
VStack {
    if selectedTab == .home {
        HomeView()
    } else if selectedTab == .settings {
        SettingsView()
    }
    // ...
}
```

## 完整示例

```swift
struct ContentView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(Tab.allCases) { tab in
                    TabButton(tab, isSelected: selectedTab == tab) {
                        withAnimation { selectedTab = tab }
                    }
                }
            }

            Divider()

            // 内容
            Group {
                switch selectedTab {
                case .home: HomeView()
                case .settings: SettingsView()
                // ...
                }
            }
        }
    }
}
```

## 完整讲解（中文）

### 为什么 SwiftUI macOS 没有 TabView

iOS 的 SwiftUI 有 `TabView`，但 macOS 版本没有这个组件。因此需要自己用 HStack + Button 实现。

### 实现思路

1. 用 enum 定义所有 Tab
2. 用 `@State` 跟踪当前选中的 Tab
3. 用 ForEach 渲染 Tab 按钮栏
4. 用 if/else 或 switch 显示对应内容
5. 用 `withAnimation` 添加过渡效果

### Tab 设计要点

- 按钮需要 `.buttonStyle(.plain)` 移除默认样式
- 选中状态用背景色或下划线标识
- 内容区使用 `frame(maxWidth: .infinity)` 占满剩余空间

import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var pathModel: PathModel
  @StateObject private var vm = HomeVM()
  
  var body: some View {
    ZStack {
      TabView(selection: $vm.selectedTab) {
        TodoListView()
          .tabItem {
            Image(vm.selectedTab == .todoList ? .todoIconSelected : .todoIcon)
          }
          .tag(Tab.todoList)
        
        MemoListView()
          .tabItem {
            Image(vm.selectedTab == .memo ? .memoIconSelected : .memoIcon)
          }
          .tag(Tab.memo)
        
        VoiceRecorderView()
          .tabItem {
            Image(vm.selectedTab == .voiceRecorder ? .recordIconSelected : .recordIcon)
          }
          .tag(Tab.voiceRecorder)
        
        TimerView()
          .tabItem {
            Image(vm.selectedTab == .timer ? .timerIconSelected : .timerIcon)
          }
          .tag(Tab.timer)
        
        SettingView()
          .tabItem {
            Image(vm.selectedTab == .setting ? .settingIconSelected : .settingIcon)
          }
          .tag(Tab.setting)
      }
      .environmentObject(vm)
      
      SeparatorLine()
    }
  }
}

// MARK: - 구분선

private struct SeparatorLine: View {
  fileprivate var body: some View {
    VStack {
      Spacer()
      
      Rectangle()
        .fill(LinearGradient(
          gradient: Gradient(colors: [.white, .gray.opacity(0.1)]),
          startPoint: .top,
          endPoint: .bottom
        ))
        .frame(height: 10)
        .padding(.bottom, 60)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .environmentObject(PathModel())
      .environmentObject(TodoListVM())
      .environmentObject(MemoListVM())
  }
}

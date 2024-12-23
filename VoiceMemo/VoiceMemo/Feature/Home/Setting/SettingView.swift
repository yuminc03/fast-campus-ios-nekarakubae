import SwiftUI

struct SettingView: View {
  @EnvironmentObject private var homeVM: HomeVM
  
  var body: some View {
    VStack {
      Title()
      
      Spacer()
        .frame(height: 35)
      
      TotalTabCount()
      
      Spacer()
        .frame(height: 40)
      
      TotalTabMoveView()
      
      Spacer()
    }
  }
}

// MARK: - Title

private struct Title: View {
  fileprivate var body: some View {
    HStack {
      Text("설정")
        .font(.system(size: 30, weight: .bold))
        .foregroundColor(.customBlack)
      
      Spacer()
    }
    .padding(.horizontal, 30)
    .padding(.top, 45)
  }
}

// MARK: - 전체 Tab 설정된 Count

private struct TotalTabCount: View {
  @EnvironmentObject private var homeVM: HomeVM
  
  fileprivate var body: some View {
    HStack {
      TabCount(title: "To do", count: homeVM.todosCount)
      
      Spacer()
        .frame(width: 70)
      
      TabCount(title: "메모", count: homeVM.memosCount)
      
      Spacer()
        .frame(width: 70)
      
      TabCount(title: "음성메모", count: homeVM.voiceRecorderCount)
    }
  }
}

// MARK: - 각 Tab 설정된 Count View (공통 View Component)

private struct TabCount: View {
  private var title: String
  private var count: Int
  
  init(title: String, count: Int) {
    self.title = title
    self.count = count
  }
  
  fileprivate var body: some View {
    VStack(spacing: 5) {
      Text(title)
        .font(.system(size: 14))
        .foregroundColor(.customBlack)
      
      Text("\(count)")
        .font(.system(size: 30, weight: .medium))
        .foregroundColor(.customBlack)
    }
  }
}

// MARK: - 전체 Tab 이동 View

private struct TotalTabMoveView: View {
  @EnvironmentObject private var homeVM: HomeVM
  
  fileprivate var body: some View {
    VStack {
      Rectangle()
        .fill(.customGray1)
        .frame(height: 1)
      
      TabMoveView(title: "To do List") {
        homeVM.changeSelectedTab(.todoList)
      }
      
      TabMoveView(title: "메모장") {
        homeVM.changeSelectedTab(.memo)
      }
      
      TabMoveView(title: "음성메모") {
        homeVM.changeSelectedTab(.voiceRecorder)
      }
      
      TabMoveView(title: "타이머") {
        homeVM.changeSelectedTab(.timer)
      }
      
      Rectangle()
        .fill(.customGray1)
        .frame(height: 1)
    }
  }
}

// MARK: - 각 Tab 이동 View

private struct TabMoveView: View {
  private var title: String
  private var tabAction: () -> Void
  
  init(title: String, tabAction: @escaping () -> Void) {
    self.title = title
    self.tabAction = tabAction
  }
  
  fileprivate var body: some View {
    Button(action: tabAction) {
      HStack {
        Text(title)
          .font(.system(size: 14))
          .foregroundColor(.customBlack)
        
        Spacer()
        
        Image(.arrowRight)
      }
    }
    .padding(20)
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView()
      .environmentObject(HomeVM())
  }
}

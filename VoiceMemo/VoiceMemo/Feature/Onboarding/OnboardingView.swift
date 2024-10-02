import SwiftUI

struct OnboardingView: View {
  @StateObject private var vm = OnboardingVM()
  
  var body: some View {
    // TODO: - 화면 전환 구현 필요
    Text("Onboarding")
  }
}

// MARK: - OnboardingContentView

private struct OnboardingContentView: View {
  @ObservedObject private var onboardingVM: OnboardingVM
  
  // 내부에서만 사용할 init
  fileprivate init(onboardingVM: OnboardingVM) {
    self.onboardingVM = onboardingVM
  }
  
  fileprivate var body: some View {
    VStack {
      // 온보딩 셀리스트 뷰
      
      // 시작 버튼 뷰
    }
  }
}

// MARK: - OnboardingCellListView

#Preview {
  OnboardingView()
}

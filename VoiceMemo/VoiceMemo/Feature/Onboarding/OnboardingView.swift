import SwiftUI

struct OnboardingView: View {
  @StateObject private var vm = OnboardingVM()
  
  var body: some View {
    // TODO: - 화면 전환 구현 필요
    OnboardingContentView(vm: vm)
  }
}

// MARK: - OnboardingContentView

private struct OnboardingContentView: View {
  @ObservedObject private var vm: OnboardingVM
  
  // 내부에서만 사용할 init
  fileprivate init(vm: OnboardingVM) {
    self.vm = vm
  }
  
  fileprivate var body: some View {
    VStack {
      // 온보딩 셀리스트 뷰
      OnboardingCellListView(vm: vm)
      // 시작 버튼 뷰
    }
  }
}

// MARK: - OnboardingCellListView

private struct OnboardingCellListView: View {
  @ObservedObject private var vm: OnboardingVM
  @State private var selectedIndex: Int
  
  fileprivate init(vm: OnboardingVM, selectedIndex: Int = 0) {
    self.vm = vm
    self.selectedIndex = selectedIndex
  }
  
  fileprivate var body: some View {
    TabView(selection: $selectedIndex) {
      ForEach(Array(vm.onboardingContents.enumerated()), id: \.element) { index, content in
        OnboardingCellView(onboardingContent: content)
          .tag(index)
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .frame(
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height / 1.5
    )
    .background(selectedIndex % 2 == 0 ? .customSky : .customBackgroundGreen)
    .clipped()
  }
}

// MARK: - OnboardingCellView

private struct OnboardingCellView: View {
  private var onboardingContent: OnboardingContent
  
  fileprivate init(onboardingContent: OnboardingContent) {
    self.onboardingContent = onboardingContent
  }
  
  fileprivate var body: some View {
    VStack {
      Image(onboardingContent.imageFileName)
        .resizable()
        .scaledToFit()
      
      HStack {
        Spacer()
        
        VStack {
          Spacer()
            .frame(height: 46)
          
          Text(onboardingContent.title)
            .font(.system(size: 16, weight: .black))
          
          Spacer()
            .frame(height: 5)
          
          Text(onboardingContent.subTitle)
            .font(.system(size: 16))
        }
        
        Spacer()
      }
      .background(.customWhite)
      .clipShape(RoundedRectangle(cornerRadius: 0))
    }
    .shadow(radius: 10)
  }
}

#Preview {
  OnboardingView()
}

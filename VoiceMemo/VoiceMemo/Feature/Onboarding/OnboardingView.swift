import SwiftUI

struct OnboardingView: View {
  @StateObject private var pathModel = PathModel()
  @StateObject private var vm = OnboardingVM()
  @StateObject private var todoListVM = TodoListVM()
  @StateObject private var memoListVM = MemoListVM()
  
  var body: some View {
    NavigationStack(path: $pathModel.paths) {
//      TodoListView()
//        .environmentObject(todoListVM)
//      OnboardingContentView(vm: vm)
      
      MemoListView()
        .environmentObject(memoListVM)
        .navigationDestination(for: PathType.self) { path in
          switch path {
          case .home:
            HomeView()
              .navigationBarBackButtonHidden()
            
          case .todo:
            TodoView()
              .navigationBarBackButtonHidden()
              .environmentObject(todoListVM)
            
          case let .memo(isCreateMode, memo):
            MemoView(
              vm: isCreateMode ?
                .init(memo: .init(title: "", content: "", date: .now)) :
                .init(memo: memo ?? .init(title: "", content: "", date: .now)),
              isCreateMode: isCreateMode
            )
            .navigationBarBackButtonHidden()
            .environmentObject(memoListVM)
          }
        }
    }
    .environmentObject(pathModel)
  }
}

// MARK: - 온보딩 Content View

private struct OnboardingContentView: View {
  @ObservedObject private var vm: OnboardingVM
  
  // 내부에서만 사용할 init
  fileprivate init(vm: OnboardingVM) {
    self.vm = vm
  }
  
  fileprivate var body: some View {
    VStack {
      OnboardingCellListView(vm: vm)
      
      Spacer()
      
      StartButton()
    }
    .edgesIgnoringSafeArea(.top)
    .background(.white)
  }
}

// MARK: - 온보딩 Cell List View

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

// MARK: - 온보딩 Cell View

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

// MARK: - 시작하기 Button

private struct StartButton: View {
  @EnvironmentObject private var pathModel: PathModel
  
  fileprivate var body: some View {
    Button {
      pathModel.paths.append(.home)
    } label: {
      HStack {
        Text("시작하기")
          .font(.system(size: 16, weight: .medium))
          .foregroundColor(.customGreen)
        
        Image(.startHome)
          .renderingMode(.template)
          .foregroundColor(.customGreen)
      }
    }
    .padding(.bottom, 50)
  }
}


#Preview {
  OnboardingView()
}

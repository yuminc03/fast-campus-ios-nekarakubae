import SwiftUI

struct MemoView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var memoListVM: MemoListVM
  @StateObject var vm: MemoVM
  @State var isCreateMode: Bool = true
  
  var body: some View {
    ZStack {
      VStack {
        CustomNavigationBar(
          leftButtonAction: {
            pathModel.paths.removeLast()
          }, rightButtonAction: {
            if isCreateMode {
              memoListVM.addMemo(vm.memo)
            } else {
              memoListVM.updateMemo(vm.memo)
            }
            
            pathModel.paths.removeLast()
          }, rightButtonType: isCreateMode ? .create : .complete
        )
        
        MemoTitle(vm: vm, isCreateMode: $isCreateMode)
          .padding(.top, 20)
        
        MemoContentInput(vm: vm)
          .padding(.top, 10)
        
        if isCreateMode == false {
          RemoveMemoButton(vm: vm)
            .padding(.trailing, 20)
            .padding(.bottom, 10)
        }
      }
    }
  }
}

// MARK: - Input Memo Title

private struct MemoTitle: View {
  @ObservedObject private var vm: MemoVM
  @FocusState private var isTitleFieldFocused: Bool
  @Binding private var isCreateMode: Bool
  
  fileprivate init(
    vm: MemoVM,
    isCreateMode: Binding<Bool>
  ) {
    self.vm = vm
    self._isCreateMode = isCreateMode
  }
  
  fileprivate var body: some View {
    TextField("제목을 입력하세요", text: $vm.memo.title)
      .font(.system(size: 30))
      .padding(.horizontal, 20)
      .focused($isTitleFieldFocused)
      .onAppear {
        if isCreateMode {
          isTitleFieldFocused = true
        }
      }
  }
}

// MARK: - Input Memo Contents

private struct MemoContentInput: View {
  @ObservedObject private var vm: MemoVM
  
  fileprivate init(vm: MemoVM) {
    self.vm = vm
  }
  
  fileprivate var body: some View {
    ZStack(alignment: .topLeading) {
      TextEditor(text: $vm.memo.content)
        .font(.system(size: 20))
      
      if vm.memo.content.isEmpty {
        Text("메모를 입력하세요.")
          .font(.system(size: 16))
          .foregroundColor(.customGray1)
          .allowsHitTesting(false)
          .padding(.top, 10)
          .padding(.leading, 5)
      }
    }
    .padding(.horizontal, 20)
  }
}

// MARK: - Delete Memo Button

private struct RemoveMemoButton: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var memoListVM: MemoListVM
  @ObservedObject private var vm: MemoVM
  
  fileprivate init(vm: MemoVM) {
    self.vm = vm
  }
  
  var body: some View {
    VStack {
      Spacer()
      
      HStack {
        Spacer()
        
        Button {
          memoListVM.removeMemo(vm.memo)
          pathModel.paths.removeLast()
        } label: {
          Image(.trash)
            .resizable()
            .frame(width: 40, height: 40)
        }
      }
    }
  }
}

struct MemoView_Previews: PreviewProvider {
  static var previews: some View {
    MemoView(vm: .init(
      memo: .init(
        title: "",
        content: "",
        date: Date()
      )
    ))
    .environmentObject(PathModel())
    .environmentObject(MemoListVM())
  }
}

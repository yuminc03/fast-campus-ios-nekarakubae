import SwiftUI

struct MemoListView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var memoListVM: MemoListVM
  
  var body: some View {
    ZStack {
      VStack {
        if memoListVM.memos.isEmpty == false {
          CustomNavigationBar(
            isDisplayLeftButton: false,
            rightButtonAction: {
              memoListVM.didTapNavigationRightButton()
            },
            rightButtonType: memoListVM.navigationBarRightButtonMode
          )
        } else {
          Spacer()
            .frame(height: 30)
        }
        
        Title()
          .padding(.top, 20)
        
        if memoListVM.memos.isEmpty {
          Announcement()
        } else {
          MemoListContent()
            .padding(.top, 20)
        }
      }
      
      WriteMemoButton()
        .padding(.trailing, 20)
        .padding(.bottom, 50)
    }
    .alert(
      "메모 \(memoListVM.removeMemoCount)개 삭제하시겠습니까?",
      isPresented: $memoListVM.isDisplayRemoveMemoAlert
    ) {
      Button("삭제", role: .destructive) {
        memoListVM.didTapRemoveButton()
      }
      
      Button("취소", role: .cancel) { }
    }
  }
}

// MARK: - Title

private struct Title: View {
  @EnvironmentObject private var vm: MemoListVM
  
  fileprivate var body: some View {
    HStack {
      if vm.memos.isEmpty {
        Text("메모를\n추가해 보세요.")
      } else {
        Text("메모 \(vm.memos.count)개가\n있습니다.")
      }
      
      Spacer()
    }
    .font(.system(size: 30, weight: .bold))
    .padding(.leading, 20)
  }
}

// MARK: - Announcement

private struct Announcement: View {
  var body: some View {
    VStack(spacing: 15) {
      Spacer()
      
      Image(.pencil)
        .renderingMode(.template)
      
      Text("\"퇴근 9시간 전 메모\"")
      Text("\"개발 끝낸 후 퇴근하기!\"")
      Text("\"밀린 알고리즘 공부하기!\"")
      
      Spacer()
    }
    .font(.system(size: 16))
    .foregroundColor(.customGray2)
  }
}

// MARK: - Memo List Contents

private struct MemoListContent: View {
  @EnvironmentObject private var vm: MemoListVM
  
  var body: some View {
    VStack {
      HStack {
        Text("메모 목록")
          .font(.system(size: 16, weight: .bold))
          .padding(.leading, 20)
        
        Spacer()
      }
      
      ScrollView(.vertical) {
        VStack(spacing: 0) {
          Rectangle()
            .fill(.customGray0)
            .frame(height: 1)
          
          ForEach(vm.memos, id: \.self) {
            MemoCell(memo: $0)
          }
        }
      }
    }
  }
}

// MARK: - Memo Cell

private struct MemoCell: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var vm: MemoListVM
  @State private var isRemoveSelected: Bool
  private var memo: Memo
  
  fileprivate init(
    isRemoveSelected: Bool = false,
    memo: Memo
  ) {
    self._isRemoveSelected = State(initialValue: isRemoveSelected)
    self.memo = memo
  }
  
  var body: some View {
    Button {
      // TODO: - path 관련 메모 작업 후 구현 필요함
    } label: {
      VStack(spacing: 10) {
        HStack {
          VStack(alignment: .leading) {
            Text(memo.title)
              .lineLimit(1)
              .font(.system(size: 16))
              .foregroundColor(.customBlack)
            
            Text(memo.convertedDate)
              .font(.system(size: 12))
              .foregroundColor(.customIconGray)
          }
          
          Spacer()
          
          if vm.isEditMemoMode {
            Button {
              isRemoveSelected.toggle()
              vm.didTapMemoRemoveSelectedBox(memo)
            } label: {
              isRemoveSelected ? Image(.selectedBox) : Image(.unSelectedBox)
            }
          }
        }
      }
      .padding(.horizontal, 30)
      .padding(.top, 10)
      
      Rectangle()
        .fill(.customGray0)
        .frame(height: 1)
    }
  }
}

private struct WriteMemoButton: View {
  @EnvironmentObject private var pathModel: PathModel
  
  fileprivate var body: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        
        Button {
          // TODO: - 메모 View 작업 후 구현
        } label: {
          Image(.writeBtn)
        }
      }
    }
  }
}

struct MemoListView_Previews: PreviewProvider {
  static var previews: some View {
    MemoListView()
      .environmentObject(PathModel())
      .environmentObject(MemoListVM())
  }
}

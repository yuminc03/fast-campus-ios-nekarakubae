import SwiftUI

struct TodoListView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var todoListVM: TodoListVM
  
  var body: some View {
    ZStack {
      VStack {
        if todoListVM.todos.isEmpty == false {
          CustomNavigationBar(
            isDisplayLeftButton: false,
            rightButtonAction: {
            todoListVM.tapNavigationRightButton()
            },
            rightButtonType: todoListVM.navigationBarRightButtonMode
          )
        } else {
          Spacer()
            .frame(height: 30)
        }
        
        TitleView()
          .padding(.top, 20)
        
        if todoListVM.todos.isEmpty {
          AnnouncementView()
        } else {
          TodoListContentView()
        }
      }
      
      WriteTodoButtonView()
        .padding(.trailing, 20)
        .padding(.bottom, 50)
    }
  }
}

private extension TodoListView {
//  var TitleView: some View {
//    Text("Title")
//  }
  
//  func titleView() -> some View {
//    Text("title")
//  }
}

// MARK: - TodoList Title View

private struct TitleView: View {
  @EnvironmentObject private var todoListVM: TodoListVM
  
  fileprivate var body: some View {
    HStack {
      if todoListVM.todos.isEmpty {
        Text("To do list를\n추가해 보세요.")
      } else {
        Text("To do list \(todoListVM.todos.count)개가\n있습니다.")
      }
      
      Spacer()
    }
    .font(.system(size: 30, weight: .bold))
    .padding(.leading, 20)
  }
}

// MARK: - Todo List 안내 View

private struct AnnouncementView: View {
  fileprivate var body: some View {
    VStack(spacing: 15) {
      Spacer()
      
      Image(.pencil)
        .renderingMode(.template)
      
      Text("\"매일 아침 8시 운동하자!\"")
      Text("\"내일 8시 수강 신청하자!\"")
      Text("\"1시 반 점심약속 리마인드 해보자!\"")
      
      Spacer()
    }
    .font(.system(size: 16))
    .foregroundColor(.customGray2)
  }
}

// MARK: - TodoList Contents View

private struct TodoListContentView: View {
  @EnvironmentObject private var todoListVM: TodoListVM
  
  fileprivate var body: some View {
    VStack {
      HStack {
        Text("할 일 목록")
          .font(.system(size: 16, weight: .bold))
          .padding(.leading, 20)
        
        Spacer()
      }
      
      ScrollView(.vertical) {
        Rectangle()
          .fill(Color.customGray0)
          .frame(height: 1)
        
        ForEach(todoListVM.todos, id: \.self) {
          TodoCellView(todo: $0)
        }
      }
    }
  }
}

// MARK: - Todo Cell View

private struct TodoCellView: View {
  @EnvironmentObject private var todoListVM: TodoListVM
  @State private var isRemoveSelected: Bool
  private var todo: Todo
  
  fileprivate init(isRemoveSelected: Bool = false, todo: Todo) {
    self._isRemoveSelected = State(initialValue: isRemoveSelected)
    self.todo = todo
  }
  
  fileprivate var body: some View {
    VStack(spacing: 20) {
      HStack {
        if todoListVM.isEditTodoMode == false {
          Button {
            todoListVM.didTapSelectedBox(todo)
          } label: {
            todo.selected ? Image(.selectedBox) : Image(.unSelectedBox)
          }
        }
        
        VStack(alignment: .leading, spacing: 5) {
          Text(todo.title)
            .font(.system(size: 16))
            .foregroundColor(todo.selected ? .customIconGray : .customBlack)
          
          Text(todo.convertedDayAndTime)
            .font(.system(size: 16))
            .foregroundColor(.customIconGray)
        }
        
        Spacer()
        
        if todoListVM.isEditTodoMode {
          Button {
            isRemoveSelected.toggle()
            todoListVM.didTapTodoRemoveSelectedBox(todo)
          } label: {
            isRemoveSelected ? Image(.selectedBox) : Image(.unSelectedBox)
          }
        }
      }
    }
    .padding(.horizontal, 20)
    .padding(.top, 10)
    
    Rectangle()
      .fill(Color.customGray0)
      .frame(height: 1)
  }
}

// MARK: - Todo 작성 버튼 View

private struct WriteTodoButtonView: View {
  @EnvironmentObject private var pathModel: PathModel
  
  fileprivate var body: some View {
    VStack {
      Spacer()
      
      HStack {
        Spacer()
        
        Button {
          pathModel.paths.append(.todo)
        } label: {
          Image(.writeBtn)
        }
      }
    }
  }
}

struct TodoListView_Previews: PreviewProvider {
  static var previews: some View {
    TodoListView()
      .environmentObject(PathModel())
      .environmentObject(TodoListVM())
  }
}

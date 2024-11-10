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
      }
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
      
      Image("pencil")
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
struct TodoListView_Previews: PreviewProvider {
  static var previews: some View {
    TodoListView()
      .environmentObject(PathModel())
      .environmentObject(TodoListVM())
  }
}

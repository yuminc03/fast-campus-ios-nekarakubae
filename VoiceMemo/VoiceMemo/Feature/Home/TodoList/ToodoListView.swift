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

struct TodoListView_Previews: PreviewProvider {
  static var previews: some View {
    TodoListView()
      .environmentObject(PathModel())
      .environmentObject(TodoListVM())
  }
}

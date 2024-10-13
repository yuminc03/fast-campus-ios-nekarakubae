import Foundation

final class TodoListVM: ObservableObject {
  @Published var todos: [Todo]
  @Published var isEditTodoMode: Bool
  @Published var removeTodos: [Todo]
  @Published var isDisplayRemoveTodoAlert: Bool
  
  var removeTdosCount: Int {
    return removeTodos.count
  }
  
  var navigationBarRightButtonMode: NavigationButtonType {
    return isEditTodoMode ? .complete : .edit
  }
  
  init(
    todos: [Todo],
    isEditTodoMode: Bool = false,
    removeTodos: [Todo],
    isDisplayRemoveTodoAlert: Bool = false
  ) {
    self.todos = todos
    self.isEditTodoMode = isEditTodoMode
    self.removeTodos = removeTodos
    self.isDisplayRemoveTodoAlert = isDisplayRemoveTodoAlert
  }
}

extension TodoListVM {
  /// todo의 checkBox를 눌렀을 때
  func didTapSelectedBox(_ todo: Todo) {
    if let index = todos.firstIndex(where: { $0 == todo }) {
      todos[index].selected.toggle()
    }
  }
  
  /// todo 추가
  func addTodo(_ todo: Todo) {
    todos.append(todo)
  }
  
  /// Navigation RightButton을 눌렀을 때
  func tapNavigationRightButton() {
    if isEditTodoMode {
      if removeTodos.isEmpty {
        isEditTodoMode = false
      } else {
        setIsDisplayRemoveTodoAlert(true)
      }
    } else {
      isEditTodoMode = true
    }
  }
  
  /// todo 삭제를 위한 alert을 띄움
  func setIsDisplayRemoveTodoAlert(_ isDisplay: Bool) {
    isDisplayRemoveTodoAlert = isDisplay
  }
  
  /// 삭제된 todo checkbox 눌렀을 때
  func didTapTodoRemoveSelectedBox(_ todo: Todo) {
    if let index = removeTodos.firstIndex(of: todo) {
      removeTodos.remove(at: index)
    } else {
      removeTodos.append(todo)
    }
  }
  
  /// 삭제하기 버튼을 눌렀을 때
  func didTapRemoveButton() {
    // removeTodos에 포함되어있는 todo들을 삭제
    todos.removeAll { todo in
      removeTodos.contains(todo)
    }
    
    removeTodos.removeAll()
    isEditTodoMode = false
  }
}

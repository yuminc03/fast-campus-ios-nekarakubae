import SwiftUI

struct TodoView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var todoListVM: TodoListVM
  @StateObject private var todoVM = TodoVM()
  
  var body: some View {
    VStack {
      CustomNavigationBar(
        leftButtonAction: {
          pathModel.paths.removeLast()
        },
        rightButtonAction: {
          todoListVM.addTodo(.init(
            title: todoVM.title,
            time: todoVM.time,
            day: todoVM.day,
            selected: false
          ))
          
          pathModel.paths.removeLast()
        },
        rightButtonType: .create
      )
      
      Title()
        .padding(.top, 20)
      
      Spacer()
        .frame(height: 20)
      
      InputTodoTitle(todoVM: todoVM)
        .padding(.leading, 20)
      
      SelectTime(todoVM: todoVM)
      
      SelectDay(todoVM: todoVM)
        .padding(.leading, 20)
      
      Spacer()
    }
  }
}

// MARK: - 제목 View

private struct Title: View {
  fileprivate var body: some View {
    HStack {
      Text("To do list를\n추가해 보세요.")
      
      Spacer()
    }
    .font(.system(size: 30, weight: .bold))
    .padding(.leading, 20)
  }
}

// MARK: - Todo 제목 입력 View

private struct InputTodoTitle: View {
  @ObservedObject private var todoVM: TodoVM
  
  fileprivate init(todoVM: TodoVM) {
    self.todoVM = todoVM
  }
  
  fileprivate var body: some View {
    TextField("제목을 입력하세요", text: $todoVM.title)
  }
}

// MARK: - 시간 선택 View

private struct SelectTime: View {
  @ObservedObject private var todoVM: TodoVM
  
  fileprivate init(todoVM: TodoVM) {
    self.todoVM = todoVM
  }
  
  fileprivate var body: some View {
    VStack {
      Rectangle()
        .fill(.customGray0)
        .frame(height: 1)
      
      DatePicker(
        "",
        selection: $todoVM.time,
        displayedComponents: [.hourAndMinute]
      )
      .labelsHidden()
      .datePickerStyle(.wheel)
      .frame(maxWidth: .infinity, alignment: .center)
      
      Rectangle()
        .fill(.customGray0)
        .frame(height: 1)
    }
  }
}

// MARK: - 날짜 선택 View
private struct SelectDay: View {
  @ObservedObject private var todoVM: TodoVM
  
  fileprivate init(todoVM: TodoVM) {
    self.todoVM = todoVM
  }
  
  fileprivate var body: some View {
    VStack(spacing: 5) {
      HStack {
        Text("날짜")
          .foregroundColor(.customIconGray)
        
        Spacer()
      }
      
      HStack {
        Button {
          todoVM.setIsDisplayCalendar(true)
        } label: {
          Text("\(todoVM.day.formattedDay)")
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(.customGreen)
        }
        .popover(isPresented: $todoVM.isDisplayCalendar) {
          DatePicker(
            "",
            selection: $todoVM.day,
            displayedComponents: [.date]
          )
          .labelsHidden()
          .datePickerStyle(.graphical)
          .frame(maxWidth: .infinity, alignment: .center)
          .padding()
          .onChange(of: todoVM.day) { _ in
            // day가 변했을 때 실행할 action
            todoVM.setIsDisplayCalendar(false)
          }
        }
        
        Spacer()
      }
    }
  }
}

struct TodoView_Previews: PreviewProvider {
  static var previews: some View {
    TodoView()
  }
}

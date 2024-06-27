//
//  TodoViewController.swift
//  MyUIKit
//
//  Created by Yumin Chu on 6/27/24.
//

import UIKit

struct TodoItem {
  let title: String
  var isCompleted: Bool
}

final class TodoViewController: UIViewController {
  
  @IBOutlet weak var todoTableView: UITableView!
  
  private var data: [TodoItem] = [
    .init(title: "commit", isCompleted: false),
    .init(title: "exercise", isCompleted: true),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .lightGray
    todoTableView.delegate = self
    todoTableView.dataSource = self
  }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return data.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = todoTableView.dequeueReusableCell(
      withIdentifier: "TodoTableViewCell",
      for: indexPath
    )
    cell.textLabel?.text = data[indexPath.row].title
    if data[indexPath.row].isCompleted {
      cell.textLabel?.textColor = .green
    } else {
      cell.textLabel?.textColor = .red
    }
    
    return cell
  }
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    todoTableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(
    _ tableView: UITableView,
    leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .normal, title: "완료") { action, view, completion in
      self.data[indexPath.row].isCompleted.toggle()
      self.todoTableView.reloadData()
      completion(true)
    }
    return .init(actions: [action])
  }
}

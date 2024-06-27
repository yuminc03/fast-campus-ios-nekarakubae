//
//  MyTableViewController.swift
//  MyUIKit
//
//  Created by LS-NOTE-00106 on 6/26/24.
//

import UIKit

class MyTableViewController: UIViewController {
  
  @IBOutlet weak var myTableView: UITableView!
  private let cellData = ["Hello TableView!", "This is UIKit", "Welcome", "I Need You", "I'm Fine"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .brown
    myTableView.backgroundColor = .green
    myTableView.delegate = self
    myTableView.dataSource = self
  }
}

extension MyTableViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return cellData.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "MyTableViewCell",
      for: indexPath
    )
    cell.textLabel?.text = cellData[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 200
    } else {
      return 60
    }
  }
}

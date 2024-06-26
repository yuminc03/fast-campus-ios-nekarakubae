//
//  MyViewController.swift
//  MyUIKit
//
//  Created by LS-NOTE-00106 on 6/26/24.
//

import UIKit

// 우리가 할 일을 정의
protocol AdminDelegate {
  func doTask()
}

class MyViewController: UIViewController {
  
  @IBOutlet weak var helloLabel: UILabel!
  @IBOutlet weak var nameTextField: UITextField!
  var admin: Admin?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
    admin = Admin(delegate: self) // 위임 받기
  }
  
  @IBAction func didTapButton(_ sender: Any) {
    if let name = nameTextField.text {
      helloLabel.text = "Hello \(name)!"
    }
    admin?.delegate.doTask()
  }
}

extension MyViewController: AdminDelegate {
  func doTask() {
    print("doTask")
  }
}

struct Admin {
  var delegate: AdminDelegate
}

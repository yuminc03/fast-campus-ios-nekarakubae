//
//  MyViewController.swift
//  MyUIKit
//
//  Created by LS-NOTE-00106 on 6/26/24.
//

import UIKit

class MyViewController: UIViewController {
  
  @IBOutlet weak var helloLabel: UILabel!
  @IBOutlet weak var nameTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
  }
  
  @IBAction func didTapButton(_ sender: Any) {
    if let name = nameTextField.text {
      helloLabel.text = "Hello \(name)!"
    }
  }
}

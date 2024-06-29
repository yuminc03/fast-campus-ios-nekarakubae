//
//  GreenViewController.swift
//  MyUIKit
//
//  Created by Yumin Chu on 6/29/24.
//

import UIKit

struct People {
  let name: String
  let age: Int
}

final class GreenViewController: UIViewController {
  @IBOutlet weak var insertNameTextField: UITextField!
  
  var friends: [People] = [
    .init(name: "lonalia", age: 21)
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goNext" {
      let vc = segue.destination as! IndigoViewController
      vc.inputName = insertNameTextField.text ?? ""
      vc.friends = friends
    }
  }
}

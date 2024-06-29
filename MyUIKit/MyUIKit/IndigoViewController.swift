//
//  IndigoViewController.swift
//  MyUIKit
//
//  Created by Yumin Chu on 6/29/24.
//

import UIKit

final class IndigoViewController: UIViewController {
  @IBOutlet weak var name: UILabel!
  
  var inputName = ""
  var friends: [People] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    name.text = friends.first?.name
  }
  
}

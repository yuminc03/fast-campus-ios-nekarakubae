//
//  ProfileDetailViewController.swift
//  MyUIKit
//
//  Created by Yumin Chu on 6/29/24.
//

import UIKit

final class ProfileDetailViewController: UIViewController {
  @IBOutlet weak var textLabel: UILabel!
  
  var inputText = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textLabel.text = inputText
  }
}

//
//  ViewController.swift
//  MyUIKit
//
//  Created by Yumin Chu on 6/25/24.
//

import UIKit

final class ViewController: UIViewController {

  @IBOutlet weak var myLabel: UILabel!
  @IBOutlet weak var myButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGray // view를 다 그렸을 때 색 바꾸기
  }
  
  @IBAction func didTapMyButton(_ sender: Any) {
    print("Tap Button")
    myLabel.text = "call didTapMyButton"
  }
}

//
//  ProfileViewController.swift
//  MyUIKit
//
//  Created by Yumin Chu on 6/29/24.
//

import UIKit

final class ProfileViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  private var profileData = ["아이디", "이메일", "전화번호"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "profileSegue" {
      let vc = segue.destination as! ProfileDetailViewController
      vc.inputText = profileData.first ?? ""
    }
  }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return profileData.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
    cell.textLabel?.text = profileData[indexPath.row]
    return cell
  }
}

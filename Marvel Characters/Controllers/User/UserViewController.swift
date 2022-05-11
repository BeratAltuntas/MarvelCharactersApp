//
//  UserViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import FirebaseAuth
import GoogleSignIn
import UIKit

// MARK: - UserViewController
class UserViewController: BaseViewController {
	static let biographyCellCount = 3
	weak var viewModel: UserViewModel! {
		didSet {
			viewModel.delegate = self
		}
	}
	
	@IBOutlet var tableView:UITableView!
	@IBOutlet var largeProfileImageView: UIImageView!
	@IBOutlet weak var miniProfileImageView:UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	
	var iconList = [UIImage]()
	var dummyPersonList = ["Berat Altuntaş", "21", "Erkek", "Kayseri / Türkiye"]
	override func viewDidLoad() {
		super.viewDidLoad()
//		if Auth.auth().currentUser == nil{
//
//		} else {
			setupNavBar()
			nameLabel.text = dummyPersonList[0]
			iconList.append(UIImage(named: "calender-icon-black")!)
			iconList.append(UIImage(named: "gender-icon-red")!)
			iconList.append(UIImage(named: "location-icon-black")!)
			
			miniProfileImageView.layer.cornerRadius = CGFloat((miniProfileImageView.frame.width)/2)
		//}
	}
}

// MARK: - UserViewModelDelegate
extension UserViewController: UserViewModelDelegate {
	
}


// MARK: - UITableViewDataSource
extension UserViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { UserViewController.biographyCellCount }
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BiographyCell",for: indexPath)
		cell.textLabel?.text = dummyPersonList[indexPath.row+1]
		cell.imageView?.image = iconList[indexPath.row]
		return cell
	}
}

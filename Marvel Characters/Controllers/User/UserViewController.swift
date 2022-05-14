//
//  UserViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import UIKit

enum UserViewConstants {
	static let biographyCellCount = 3
	static let biographyCellId = "BiographyCell"
	static let createUserViewControllerId = ""
}
// MARK: - UserViewController
final class UserViewController: BaseViewController {
	
	var viewModel: UserViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	
	@IBOutlet var tableView: UITableView!
	@IBOutlet var largeProfileImageView: UIImageView!
	@IBOutlet weak var miniProfileImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	
	var iconList = [UIImage]()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if viewModel.CheckUserSignedIn(){
			viewModel.LoadUI()
		} else {
			performSegue(withIdentifier: UserViewConstants.createUserViewControllerId, sender: self)
		}
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == UserViewConstants.createUserViewControllerId {
			let targetVC = segue.destination as! CreateUserViewController
			targetVC.viewModel = CreateUserViewModel()
		}
	}
}

// MARK: - UserViewModelDelegate
extension UserViewController: UserViewModelDelegate {
	func SetupUI() {
		setupNavBar()
		iconList.append(UIImage(named: "calender-icon-black")!)
		iconList.append(UIImage(named: "gender-icon-red")!)
		iconList.append(UIImage(named: "location-icon-black")!)
		miniProfileImageView.layer.cornerRadius = CGFloat((miniProfileImageView.frame.width)/2)
	}
	func ReloadTableView() {
		tableView.reloadData()
	}
}


// MARK: - UITableViewDataSource
extension UserViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { UserViewConstants.biographyCellCount }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: UserViewConstants.biographyCellId,for: indexPath)
		//cell.textLabel?.text = dummyPersonList[indexPath.row+1]
		cell.imageView?.image = iconList[indexPath.row]
		return cell
	}
}


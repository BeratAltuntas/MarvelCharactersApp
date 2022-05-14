//
//  UserViewControllerModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import FirebaseAuth
import Foundation

// MARK: - UserViewModelProtocol
protocol UserViewModelProtocol {
	var delegate: UserViewModelDelegate? { get set }
	var uId: String { get }
	var email: String { get }
	var name: String { get }
	var imageUrl: URL { get }
	
	func LoadUI()
	func LoadUserInfos()
	func CheckUserSignedIn()-> Bool
	
}

// MARK: - UserViewModelDelegate
protocol UserViewModelDelegate: AnyObject {
	func SetupUI()
	func ReloadTableView()
}

// MARK: - UserViewModel
final class UserViewModel {
	weak var delegate: UserViewModelDelegate?
	var userId: String?
	var userEmail: String?
	var userName: String?
	var userImageUrl: URL?
}

// MARK: - UserViewModelExtension
extension UserViewModel: UserViewModelProtocol {
	var imageUrl: URL {
		userImageUrl ?? URL(string: "")!
	}
	
	var uId: String {
		userId ?? ""
	}
	
	var email: String {
		userEmail ?? ""
	}
	
	var name: String {
		userName ?? ""
	}
	
	
	func LoadUserInfos() {
		let user = Auth.auth().currentUser
		if let user = user {
			userId = user.uid
			userEmail = user.email
			userName = user.displayName
			userImageUrl = user.photoURL
		}
	}
	
	func LoadUI() {
		delegate?.SetupUI()
	}
	func CheckUserSignedIn()-> Bool {
		if Auth.auth().currentUser == nil{
			return false
		}
		return true
	}
}

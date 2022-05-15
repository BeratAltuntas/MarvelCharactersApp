//
//  UserViewControllerModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import Foundation

typealias UserViewCompletion = (_ success: Bool) -> Void

// MARK: - UserViewModelProtocol
protocol UserViewModelProtocol {
	var delegate: UserViewModelDelegate? { get set }
	var user: User { get }
	
	func LoadUI()
	func LoadUserInfos(completion: @escaping UserViewCompletion)
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
	var userViewModel: User?
}

// MARK: - UserViewModelExtension
extension UserViewModel: UserViewModelProtocol {
	
	var user: User {
		userViewModel ?? User(data: ["":""])
	}
	
	func LoadUserInfos(completion: @escaping UserViewCompletion) {
		FireBaseDatabaseManager.shared.GetUserInDatabase(withUid: FirebaseAuthManager.shared.GetUserUid()!) { [weak self] (success, result) in
			if success {
				self?.userViewModel = result
				completion(true)
			}
		}
	}
	
	func LoadUI() {
		delegate?.SetupUI()
	}
	func CheckUserSignedIn()-> Bool {
		FirebaseAuthManager.shared.IsUserSignedIn()
	}
}

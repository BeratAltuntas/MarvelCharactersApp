//
//  UserViewControllerModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import FirebaseAuth
import GoogleSignIn
import Foundation

// MARK: - UserViewModelProtocol
protocol UserViewModelProtocol {
	var delegate: UserViewModelDelegate? { get set }
	
	func LoadUI()
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
	
}

// MARK: - UserViewModelExtension
extension UserViewModel: UserViewModelProtocol {
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

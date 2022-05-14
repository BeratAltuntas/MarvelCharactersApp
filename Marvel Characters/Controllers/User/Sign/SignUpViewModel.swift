//
//  CreateUserViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//
import FirebaseAuth
import Foundation

// MARK: - SignUpViewModelProtocol
protocol SignUpViewModelProtocol {
	var delegate: SignUpViewModelDelegate? { get set }
	
	func CreateUser(email: String, password: String)
	func UpdateUsersName(name: String)
}

// MARK: - SignUpViewModelDelegate
protocol SignUpViewModelDelegate: AnyObject {
	func Dissmiss()
}

// MARK: - SignUpViewModel
final class SignUpViewModel {
	weak var delegate: SignUpViewModelDelegate?
}

// MARK: - Extension: SignUpViewModelProtocol
extension SignUpViewModel: SignUpViewModelProtocol {
	func CreateUser(email: String, password: String) {
		Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
			if error == nil {
				self?.delegate?.Dissmiss()
			}
		}
	}
	func UpdateUsersName(name: String) {
		let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
		changeRequest?.displayName = name
		changeRequest?.commitChanges()
	}
}

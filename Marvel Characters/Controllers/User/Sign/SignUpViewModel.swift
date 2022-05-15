//
//  CreateUserViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//
import Foundation

// MARK: - SignUpViewModelProtocol
protocol SignUpViewModelProtocol {
	var delegate: SignUpViewModelDelegate? { get set }
	
	func CreateUser(name: String, email: String, password: String)
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
	func CreateUser(name: String, email: String, password: String) {
		FirebaseAuthManager.shared.CreateUser(email: email, password: password) { (success, uId) in
			if success {
				FireBaseDatabaseManager.shared.CreateUserInDatabase(uId: uId, name: name, email: email, password: password) { [weak self] (success) in
					if success {
						self?.delegate?.Dissmiss()
					}
				}
			}
		}
	}
}

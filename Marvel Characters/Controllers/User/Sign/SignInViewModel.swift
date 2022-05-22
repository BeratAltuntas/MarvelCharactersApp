//
//  SignInViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//
import Foundation

// MARK: - SignInViewModelProtocol
protocol SignInViewModelProtocol {
	var delegate: SignInViewModelDelegate? { get set }
	
	func SignIn(email: String, password: String)
}

// MARK: - SignInViewModelDelegate
protocol SignInViewModelDelegate: AnyObject {
	func Dissmiss()
}

// MARK: - SignInViewModel
final class SignInViewModel {
	internal weak var delegate: SignInViewModelDelegate?
}

// MARK: - Extension: SignInViewModelProtocol
extension SignInViewModel: SignInViewModelProtocol {
	func SignIn(email: String, password: String) {
		FirebaseAuthManager.shared.SignIn(withEmail: email, password: password) {[weak self] (success, uId) in
			if success {
				self?.delegate?.Dissmiss()
			}
		}
	}
}


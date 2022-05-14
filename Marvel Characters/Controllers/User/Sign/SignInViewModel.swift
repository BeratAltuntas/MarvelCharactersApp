//
//  SignInViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//
import FirebaseAuth
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
	weak var delegate: SignInViewModelDelegate?
}

// MARK: - Extension: SignInViewModelProtocol
extension SignInViewModel: SignInViewModelProtocol {
	func SignIn(email: String, password: String) {
		Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
			if error == nil {
				self?.delegate?.Dissmiss()
			}
		}
	}
}


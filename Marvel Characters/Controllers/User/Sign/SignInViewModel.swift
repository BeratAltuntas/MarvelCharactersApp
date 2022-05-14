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
	
	func SignIn(email: String, password: String)-> Bool
}

// MARK: - SignInViewModelDelegate
protocol SignInViewModelDelegate: AnyObject {
	
}

// MARK: - SignInViewModel
final class SignInViewModel {
	weak var delegate: SignInViewModelDelegate?
}

// MARK: - Extension: SignInViewModelProtocol
extension SignInViewModel: SignInViewModelProtocol {
	func SignIn(email: String, password: String) -> Bool {
		var returnValue = false
		Auth.auth().signIn(withEmail: email, password: password) { result, error in
			if error != nil {
				returnValue = true
				
			} else {
				returnValue = false
			}
		}
		return returnValue
	}
}


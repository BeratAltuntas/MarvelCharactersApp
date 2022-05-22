//
//  SignInViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import UIKit

// MARK: - SignInViewController
final class SignInViewController: BaseViewController {
	@IBOutlet private weak var textFieldEmail: UITextField!
	@IBOutlet private weak var textFieldPassword: UITextField!
	
	internal var viewModel: SignInViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	@IBAction func SignIn_TUI(_ sender: Any) {
		if let email = textFieldEmail.text,
		   let password = textFieldPassword.text {
			if !password.isEmpty && !email.isEmpty && email.contains("@") {
				viewModel.SignIn(email: email, password: password)
			}
		}
	}
}

// MARK: - Extension: SignInViewModelDelegate
extension SignInViewController: SignInViewModelDelegate {
	func Dissmiss() {
		_ = navigationController?.popToRootViewController(animated: true)
	}
}

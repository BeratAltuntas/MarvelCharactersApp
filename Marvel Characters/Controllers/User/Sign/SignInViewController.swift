//
//  SignInViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import UIKit

// MARK: - SignInViewController
final class SignInViewController: BaseViewController {

	var viewModel: SignInViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	@IBOutlet weak var textFieldEmail: UITextField!
	@IBOutlet weak var textFieldPassword: UITextField!
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

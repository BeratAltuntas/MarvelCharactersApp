//
//  CreateUserViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import UIKit

// MARK: - SignUpViewController
final class SignUpViewController: BaseViewController {
	
	var viewModel: SignUpViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	@IBOutlet weak var textFieldNameSurname: UITextField!
	@IBOutlet weak var textFieldEmail: UITextField!
	@IBOutlet weak var textFieldPassword: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == UserViewConstants.signInViewControllerId {
			let targetVC = segue.destination as! SignInViewController
			targetVC.viewModel = SignInViewModel()
		}
	}
	@IBAction func SignUp_TUI(_ sender: Any) {
		if let name = textFieldNameSurname.text,
		   let email = textFieldEmail.text,
		   let password = textFieldPassword.text {
			if email.contains("@") && password.count >= 8 {
				viewModel.CreateUser(email: email, password: password)
			}
		}
	}
	
	@IBAction func SignUpWithGoogle_TUI(_ sender: Any) {
	}
}

// MARK: - Extension: SignUpViewModelDelegate
extension SignUpViewController: SignUpViewModelDelegate {
	func Dissmiss() {
		_ = navigationController?.popViewController(animated: true)
	}
}

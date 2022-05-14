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
	}
	@IBAction func SignInWithGoogle_TUI(_ sender: Any) {
	}
}

// MARK: - Extension: SignInViewModelDelegate
extension SignInViewController: SignInViewModelDelegate {
	
}

//
//  CreateUserViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import UIKit

class SignUpViewController: BaseViewController {

	var viewModel: SignUpViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == UserViewConstants.signInViewControllerId {
			let targetVC = segue.destination as! SignInViewController
			targetVC.viewModel = SignInViewModel()
		}
	}
}

extension SignUpViewController: SignUpViewModelDelegate {
	
}

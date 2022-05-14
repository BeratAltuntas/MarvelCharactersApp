//
//  SignInViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import UIKit

class SignInViewController: UIViewController {

	var viewModel: SignInViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension SignInViewController: SignInViewModelDelegate {
	
}

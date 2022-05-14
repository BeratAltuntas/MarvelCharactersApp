//
//  CreateUserViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import UIKit

class CreateUserViewController: BaseViewController {

	var viewModel: CreateUserViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension CreateUserViewController: CreateUserViewModelDelegate {
	
}

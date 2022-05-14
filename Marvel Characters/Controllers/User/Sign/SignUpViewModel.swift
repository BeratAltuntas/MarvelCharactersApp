//
//  CreateUserViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import Foundation

// MARK: - SignUpViewModelProtocol
protocol SignUpViewModelProtocol {
	var delegate: SignUpViewModelDelegate? { get set }
}

// MARK: - SignUpViewModelDelegate
protocol SignUpViewModelDelegate: AnyObject {
	
}

// MARK: - SignUpViewModel
final class SignUpViewModel {
	weak var delegate: SignUpViewModelDelegate?
}

// MARK: - Extension: SignUpViewModelProtocol
extension SignUpViewModel: SignUpViewModelProtocol {
	
}

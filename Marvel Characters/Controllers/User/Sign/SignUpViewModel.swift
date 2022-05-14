//
//  CreateUserViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import Foundation

// MARK: - CreateUserViewModelProtocol
protocol SignUpViewModelProtocol {
	var delegate: SignUpViewModelDelegate? { get set }
}

// MARK: - CreateUserViewModelDelegate
protocol SignUpViewModelDelegate: AnyObject {
	
}

// MARK: - CreateUserViewModel
final class SignUpViewModel {
	weak var delegate: SignUpViewModelDelegate?
}

// MARK: - Extension: CreateUserViewModelProtocol
extension SignUpViewModel: SignUpViewModelProtocol {
	
}

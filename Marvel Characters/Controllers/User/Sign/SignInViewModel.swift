//
//  SignInViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import Foundation

// MARK: - SignInViewModelProtocol
protocol SignInViewModelProtocol {
	var delegate: SignInViewModelDelegate? { get set }
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
	
}


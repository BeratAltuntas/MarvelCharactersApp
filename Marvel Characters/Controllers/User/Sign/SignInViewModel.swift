//
//  SignInViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import Foundation

protocol SignInViewModelProtocol {
	var delegate: SignInViewModelDelegate? { get set }
}

protocol SignInViewModelDelegate: AnyObject {
	
}

final class SignInViewModel {
	weak var delegate: SignInViewModelDelegate?
}

extension SignInViewModel: SignInViewModelProtocol {
	
}


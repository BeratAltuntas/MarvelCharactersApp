//
//  CreateUserViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import Foundation

// MARK: - CreateUserViewModelProtocol
protocol CreateUserViewModelProtocol {
	var delegate: CreateUserViewModelDelegate? { get set }
}

// MARK: - CreateUserViewModelDelegate
protocol CreateUserViewModelDelegate: AnyObject {
	
}

// MARK: - CreateUserViewModel
final class CreateUserViewModel {
	weak var delegate: CreateUserViewModelDelegate?
}

// MARK: - Extension: CreateUserViewModelProtocol
extension CreateUserViewModel: CreateUserViewModelProtocol {
	
}

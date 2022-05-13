//
//  CharacterPageModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 1.05.2022.
//

import Foundation

// MARK: - CharacterPageViewModelProtocol
protocol CharacterPageViewModelProtocol {
	var delegate: CharacterPageViewModelDelegate? { get set }
	func Load()
}

// MARK: - CharacterPageViewModelDelegate
protocol CharacterPageViewModelDelegate: AnyObject {
	func SetupTableViews()
	func ReloadTableViews()
	func SetPageAttiributes()
}

// MARK: - CharacterPageViewModel
final class CharacterPageViewModel {
	weak var delegate: CharacterPageViewModelDelegate?
}

// MARK: - Extension CharacterPageViewModel
extension CharacterPageViewModel: CharacterPageViewModelProtocol {

	func Load() {
		delegate?.SetupTableViews()
		delegate?.SetPageAttiributes()
		delegate?.ReloadTableViews()
	}
}

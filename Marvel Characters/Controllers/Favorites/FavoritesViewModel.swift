//
//  FavoritesViewControllerModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import Foundation
// MARK: - FavoriteViewModelProtocol
protocol FavoritesViewModelProtocol {
	var delegate: FavoritesViewModelDelegate? { get set }
	
	func loadScreen()
}

// MARK: - FavoriteViewModelDelegate
protocol FavoritesViewModelDelegate: AnyObject {
	func SetupUI()
	func SetupCell()
}

// MARK: - FavoriteViewModel
final class FavoritesViewModel {
	weak var delegate: FavoritesViewModelDelegate?
}

// MARK: - FavoriteViewModelExtension
extension FavoritesViewModel: FavoritesViewModelProtocol {
	func loadScreen() {
		delegate?.SetupCell()
		delegate?.SetupUI()
	}
}

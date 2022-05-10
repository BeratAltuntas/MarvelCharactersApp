    //
    //  FavoritesViewControllerModel.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 26.04.2022.
    //

import Foundation
    // MARK: - FavoriteViewModelProtocol
protocol FavoriteViewModelProtocol {
    var delegate: FavoriteViewModelDelegate? { get set }
}

    // MARK: - FavoriteViewModelDelegate
protocol FavoriteViewModelDelegate: AnyObject {
    
}

    // MARK: - FavoriteViewModel
final class FavoriteViewModel {
    weak var delegate: FavoriteViewModelDelegate?
}

    // MARK: - FavoriteViewModelExtension
extension FavoriteViewModel: FavoriteViewModelProtocol {
    
    
}

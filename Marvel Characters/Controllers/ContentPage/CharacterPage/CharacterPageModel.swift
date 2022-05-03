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
}

    // MARK: - CharacterPageViewModelDelegate
protocol CharacterPageViewModelDelegate: AnyObject {
}

    // MARK: - CharacterPageViewModel
final class CharacterPageViewModel {
    weak var delegate: CharacterPageViewModelDelegate?
}

    // MARK: - Extension CharacterPageViewModel
extension CharacterPageViewModel: CharacterPageViewModelProtocol {
    
}

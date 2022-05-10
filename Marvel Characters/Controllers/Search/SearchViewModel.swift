    //
    //  SearchViewControllerModel.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 26.04.2022.
    //

import Foundation

    // MARK: - SearchViewModelProtocol
protocol SearchViewModelProtocol {
    var delegate: SearchViewModelDelegate? { get set }
}

    // MARK: - SearchViewModelDelegate
protocol SearchViewModelDelegate: AnyObject {
    
}
    // MARK: - SearchViewModel
final class SearchViewModel {
    weak var delegate: SearchViewModelDelegate?
}

    // MARK: - SearchViewModelExtension
extension SearchViewModel: SearchViewModelProtocol {
    
}

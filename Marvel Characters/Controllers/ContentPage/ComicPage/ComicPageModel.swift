    //
    //  ComicPageModel.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 1.05.2022.
    //

import Foundation
import UIKit

// MARK: - ComicPageViewModelProtocol
protocol ComicPageViewModelProtocol {
    var delegate: ComicPageViewModelDelegate? { get set }
    
    func loadComicAttiributes(comic: ComicModelResult?)
}

// MARK: - ComicPageViewModelDelegate
protocol ComicPageViewModelDelegate: AnyObject {
    func setupTableViews()
    func setupUI()
    func reloadTableViews()
}

// MARK: - ComicPageViewModel
final class ComicPageViewModel {
    weak var delegate: ComicPageViewModelDelegate?

}

// MARK: - Extension ComicPageViewModel
extension ComicPageViewModel: ComicPageViewModelProtocol {
    func loadComicAttiributes(comic: ComicModelResult?) {
        delegate?.setupTableViews()
        delegate?.setupUI()
    }
}




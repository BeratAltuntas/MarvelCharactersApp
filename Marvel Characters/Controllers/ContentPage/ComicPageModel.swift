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
    
    func loadCharAttiributes(comic: ComicModelResult?)
}
// MARK: - ComicPageViewModelDelegate
protocol ComicPageViewModelDelegate: AnyObject {
    var imageViewBannerModel: UIImageView? { get set }
    var labelTitleModel: UILabel? { get set }
    var labelSubtitleModel: UILabel? { get set }
    var labelDescriptionModel: UILabel? { get set }
    var tableViewCharactersModel: UITableView? { get set }
    var tableViewWritersModel: UITableView? { get set }
}

// MARK: - ComicPageViewModel
final class ComicPageViewModel {
    weak var delegate: ComicPageViewModelDelegate?

}
// MARK: - Extension ComicPageViewModel
extension ComicPageViewModel: ComicPageViewModelProtocol {
    func loadCharAttiributes(comic: ComicModelResult?) {
        delegate?.labelTitleModel?.text = comic?.title
        delegate?.labelSubtitleModel?.text = comic?.resultDescription
    }
}




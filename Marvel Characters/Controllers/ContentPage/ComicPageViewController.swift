    //
    //  ComicPageViewController.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 30.04.2022.
    //

import UIKit

final class ComicPageViewController: BaseViewController {
    
    @IBOutlet weak var imageViewBanner: UIImageView?
    @IBOutlet weak var labelTitle: UILabel?
    @IBOutlet weak var labelSubtitle: UILabel?
    @IBOutlet weak var labelDescription: UILabel?
    @IBOutlet weak var tableViewCharacter: UITableView?
    @IBOutlet weak var tableViewWriter: UITableView?
    
    var viewModel: ComicPageViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    var comic: ComicModelResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadCharAttiributes(comic: comic)
    }
}

    // MARK: - Extension ComicPageViewController
extension ComicPageViewController: ComicPageViewModelDelegate {
    
    var imageViewBannerModel: UIImageView? {
        get {
            imageViewBanner
        }
        set (value) {
            self.imageViewBanner = value
        }
    }
    
    var labelTitleModel: UILabel? {
        get {
            labelTitle
        }
        set (value) {
            self.labelTitle = value
        }
    }
    
    var labelSubtitleModel: UILabel? {
        get {
            labelSubtitle
        }
        set (value) {
            self.labelSubtitle = value
        }
    }
    
    var labelDescriptionModel: UILabel? {
        get {
            labelDescription
        }
        set (value) {
            self.labelDescription = value
        }
    }
    
    var tableViewCharactersModel: UITableView? {
        get {
            tableViewCharacter
        }
        set (value) {
            self.tableViewCharacter = value
        }
    }
    
    var tableViewWritersModel: UITableView? {
        get {
            tableViewWriter
        }
        set (value) {
            self.tableViewWriter = value
        }
    }
}

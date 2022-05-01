//
//  ComicPageViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 30.04.2022.
//

import UIKit

final class ComicPageViewController: BaseViewController {

    @IBOutlet weak var imageViewBanner: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var tableViewCharacter: UITableView!
    @IBOutlet weak var tableViewWriter: UITableView!
    
    var viewModel: ComicPageViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    var comic: ComicModelResult?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ComicPageViewController: ComicPageViewModelDelegate {
    
}

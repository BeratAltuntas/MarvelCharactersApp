    //
    //  CharacterPageViewController.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 26.04.2022.
    //

import UIKit

    // MARK: - CharacterPageViewController
final class CharacterPageViewController: BaseViewController {
    
    var character: CharacterModelResult?
    var viewModel: CharacterPageViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

    // MARK: - Extension CharacterPageViewController
extension CharacterPageViewController: CharacterPageViewModelDelegate {
    
}

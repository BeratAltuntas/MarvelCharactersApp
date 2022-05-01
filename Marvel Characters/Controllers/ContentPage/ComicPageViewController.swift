//
//  ComicPageViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 30.04.2022.
//

import UIKit

class ComicPageViewController: BaseViewController {

    var comic: ComicModelResult?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(comic?.title)
    }
}

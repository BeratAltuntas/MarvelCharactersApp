//
//  UIViewController+NavBar.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 27.04.2022.
//

import UIKit

class BaseViewController: UIViewController {
    func setupNavBar() {
        let navImageView = UIImageView(image: UIImage(named: "Marvel_Logo"))
        guard let navigationBar = navigationController?.navigationBar else{return}
        
        navigationBar.addSubview(navImageView)
        navImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navImageView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            navImageView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            navImageView.widthAnchor.constraint(equalToConstant: 100),
            navImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension BaseViewController {
    public enum Constant {
        static let cellIdentifier = "ContentPage"
        static let forYouCollectionViewTag = 0
        static let trendsCollectionViewTag = 1
        
        static let homeToCharPageSegueID = "HomeToChar"
        static let homeToComicPageSegueID = "HomeToComic"
    }
}

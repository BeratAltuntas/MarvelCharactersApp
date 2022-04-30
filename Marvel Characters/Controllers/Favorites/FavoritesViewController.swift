//
//  FavoritesViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import UIKit

class FavoritesViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var favoritesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        favoritesCollectionView.register(UINib(nibName: "FavoritesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteCell")
        
        favoritesCollectionView.collectionViewLayout = FavoriteCellFlowLayout(sutunSayisi: 2, minSutunAraligi: 15, minSatirAraligi: 15)
    }
}

extension FavoritesViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoritesCollectionViewCell
        cell.favoritesImageView.image = UIImage(named: "Marvel_Logo")
        cell.characterNameLabel.text = "Iron Man \(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "ContentPage") as? CharacterPageViewController{
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}


//
//  FavoritesViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import UIKit


enum CellProperties {
	static let cellNibName = "FavoritesCollectionViewCell"
	static let favoritesCellIdentifier = "FavoriteCell"
}

// MARK: - FavoritesViewController
class FavoritesViewController: BaseViewController {
	weak var viewModel: FavoritesViewModel! {
		didSet {
			viewModel.delegate = self
		}
	}
	
    @IBOutlet var favoritesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
		viewModel.loadScreen()
    }
}

// MARK: - FavoriteViewModelDelegate
extension FavoritesViewController: FavoritesViewModelDelegate {
	func SetupUI() {
		setupNavBar()
	}
	func SetupCell() {
		favoritesCollectionView.register(UINib(nibName: "FavoritesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteCell")
		favoritesCollectionView.collectionViewLayout = FavoriteCellFlowLayout(ColumnCount: 2, MinColumnSpace: 15, MinRowSpace: 15)
	}
}

// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 6 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoritesCollectionViewCell
        cell.favoritesImageView.image = UIImage(named: "Marvel_Logo")
        cell.characterNameLabel.text = "Iron Man \(indexPath.row)"
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let viewController = storyboard?.instantiateViewController(withIdentifier: "ContentPage") as? CharacterPageViewController{
			navigationController?.pushViewController(viewController, animated: true)
		}
	}
}

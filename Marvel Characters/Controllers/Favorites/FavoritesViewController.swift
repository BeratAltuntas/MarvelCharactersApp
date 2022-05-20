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
	var viewModel: FavoritesViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	
	var comicsList = [ComicModelResult]()
	@IBOutlet var favoritesCollectionView: UICollectionView!
	override func viewDidLoad() {
	}
	override func viewWillAppear(_ animated: Bool) {
		viewModel.LoadScreen()
	}
}

// MARK: - FavoriteViewModelDelegate
extension FavoritesViewController: FavoritesViewModelDelegate {
	
	func SetupUI() {
		setupNavBar()
	}
	func SetupCell() {
		favoritesCollectionView.register(UINib(nibName: CellProperties.cellNibName, bundle: nil), forCellWithReuseIdentifier: CellProperties.favoritesCellIdentifier)
		favoritesCollectionView.collectionViewLayout = FavoriteCellFlowLayout(ColumnCount: 2, MinColumnSpace: 15, MinRowSpace: 15)
	}
	func ReloadCollectionView() {
		DispatchQueue.main.async {[weak self] in
			self?.favoritesCollectionView.reloadData()
		}
	}
}

// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { viewModel.comics!.count }
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellProperties.favoritesCellIdentifier, for: indexPath) as! FavoritesCollectionViewCell
		
		var image = viewModel.comics?[indexPath.row].images?.first?.path ?? nil
		if image == nil {
			image = viewModel.comics[indexPath.row].thumbnail?.path!
		}
		
		cell.setupCell(imageName: image, title: viewModel.comics?[indexPath.row].title)
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

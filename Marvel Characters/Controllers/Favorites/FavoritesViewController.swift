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
enum FavoritesSegueProperties {
	static let favoriteToComic = "FavoriteToComic"
	static let favoriteToChar = "FavoriteToChar"
}

// MARK: - FavoritesViewController
final class FavoritesViewController: BaseViewController {
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet private weak var favoritesCollectionView: UICollectionView!
	
	internal var viewModel: FavoritesViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	private let refreshControl = UIRefreshControl()
	private var comicsList = [ComicModelResult]()
	private var selectedCellIndex = 0
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		viewModel.LoadScreen()
	}
	func SetIndicator() {
		StartIndicator()
		if #available(iOS 10.0, *) {
			favoritesCollectionView.refreshControl = refreshControl
		} else {
			favoritesCollectionView.addSubview(refreshControl)
		}
		refreshControl.addTarget(self, action: #selector(RefreshData(_:)), for: .valueChanged)
	}
	@objc func RefreshData(_ sender: Any) {
		StartIndicator()
		viewModel.LoadComicsChars()
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == FavoritesSegueProperties.favoriteToComic {
			let target = segue.destination as? ComicPageViewController
			target?.viewModel = ComicPageViewModel()
			target?.selectedComic = viewModel.comics[selectedCellIndex]
		} else if segue.identifier == FavoritesSegueProperties.favoriteToChar {
			let target = segue.destination as? CharacterPageViewController
			target?.viewModel = CharacterPageViewModel()
			target?.selectedCharacter = viewModel.characters[selectedCellIndex - viewModel.comics.count]
		}
	}
	func SetupCell() {
		favoritesCollectionView.register(UINib(nibName: CellProperties.cellNibName, bundle: nil), forCellWithReuseIdentifier: CellProperties.favoritesCellIdentifier)
		favoritesCollectionView.collectionViewLayout = FavoriteCellFlowLayout(ColumnCount: 2, MinColumnSpace: 15, MinRowSpace: 15)
	}
}

// MARK: - FavoriteViewModelDelegate
extension FavoritesViewController: FavoritesViewModelDelegate {
	func SetupUI() {
		setupNavBar()
		SetIndicator()
		SetupCell()
	}
	func ReloadCollectionView() {
		DispatchQueue.main.async {[weak self] in
			self?.favoritesCollectionView.reloadData()
			self?.refreshControl.endRefreshing()
		}
	}
	func StartIndicator() {
		DispatchQueue.main.async { [weak self] in
			self?.activityIndicator.startAnimating()
		}
	}
	func StopIndicator() {
		DispatchQueue.main.async {[weak self] in
			self?.activityIndicator.stopAnimating()
		}
	}
}
// MARK: - Extension: FavoritesViewControllerCellDelegate
extension FavoritesViewController: FavoritesViewControllerCellDelegate {
	func ReloadCollectionViewForCell() {
		viewModel.LoadComicsChars()
	}
}

// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { viewModel.comics.count + viewModel.characters.count }
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellProperties.favoritesCellIdentifier, for: indexPath) as! FavoritesCollectionViewCell
		cell.delegate = self
		if indexPath.row < viewModel.comics.count {
			cell.cellId = "comic"
			cell.comic = viewModel.comics?[indexPath.row].id
			var image = viewModel.comics?[indexPath.row].images?.first?.path ?? nil
			if image == nil {
				image = viewModel.comics[indexPath.row].thumbnail?.path!
			}
			cell.setupCell(imageName: image, title: viewModel.comics?[indexPath.row].title)
		} else {
			cell.cellId = "char"
			cell.char = viewModel.characters[indexPath.row - viewModel.comics.count].id
			let image = viewModel.characters[indexPath.row - viewModel.comics.count].thumbnail?.path!
			cell.setupCell(imageName: image, title: viewModel.characters?[indexPath.row - viewModel.comics.count].name)
		}
		return cell
	}
}

// MARK: - UICollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectedCellIndex = indexPath.row
		let cell = collectionView.cellForItem(at: indexPath) as! FavoritesCollectionViewCell
		if cell.cellId == "comic" {
			performSegue(withIdentifier: FavoritesSegueProperties.favoriteToComic, sender: self)
		} else if cell.cellId == "char" {
			performSegue(withIdentifier: FavoritesSegueProperties.favoriteToChar, sender: self)
		}
	}
}

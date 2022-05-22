//
//  HomeViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import UIKit

enum HomeConstant {
	static let cellIdentifier = "ComicsCollectionViewCell"
	static let forYouCollectionViewTag = 0
	static let trendsCollectionViewTag = 1
	
	static let homeToCharPageSegueID = "HomeToChar"
	static let homeToComicPageSegueID = "HomeToComic"
}


final class HomeViewController: BaseViewController {
	@IBOutlet private weak var forYouCollectionView: UICollectionView!
	@IBOutlet private weak var trendsCollectionView: UICollectionView!
	@IBOutlet private weak var forYouIndicator: UIActivityIndicatorView!
	@IBOutlet private weak var trendsIndicator: UIActivityIndicatorView!
	
	lazy var indexOfSelectedCollectionCell: Int = 0
	var viewModel: HomeViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	override func viewWillAppear(_ animated: Bool) {
		AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.load()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == HomeConstant.homeToCharPageSegueID {
			let targetVC = segue.destination as! CharacterPageViewController
			targetVC.viewModel = CharacterPageViewModel()
			targetVC.selectedCharacter = viewModel.characters![indexOfSelectedCollectionCell]
			
		} else if segue.identifier == HomeConstant.homeToComicPageSegueID {
			let targetVC = segue.destination as! ComicPageViewController
			targetVC.viewModel = ComicPageViewModel()
			targetVC.selectedComic = viewModel.comics![indexOfSelectedCollectionCell]
		}
	}
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
	func setupCollectionViews() {
		forYouCollectionView.tag = HomeConstant.forYouCollectionViewTag
		forYouCollectionView.register(cell: ComicsCollectionViewCell.self)
		trendsCollectionView.tag = HomeConstant.trendsCollectionViewTag
		trendsCollectionView.register(cell: ComicsCollectionViewCell.self)
	}
	
	func reloadCollectionViews(){
		forYouCollectionView.reloadData()
		trendsCollectionView.reloadData()
	}
	
	func setupNavigationBar() {
		setupNavBar()
	}
	func StartIndicators() {
		forYouIndicator.startAnimating()
		trendsIndicator.startAnimating()
	}
	func StopIndicators() {
		forYouIndicator.stopAnimating()
		trendsIndicator.stopAnimating()
	}
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView.tag == 0 {
			return viewModel.comics?.count ?? 0
		} else if collectionView.tag == 1 {
			return viewModel.comics?.count ?? 0
		}
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeConstant.cellIdentifier, for: indexPath) as! ComicsCollectionViewCell
		
		if collectionView.tag == HomeConstant.forYouCollectionViewTag {
			var image = viewModel.comics![indexPath.row].images?.first?.path ?? nil
			if (image == nil) {
				image =  viewModel.comics![indexPath.row].thumbnail?.path!
			}
			if let price = viewModel.comics![indexPath.row].prices?[0].price{
				cell.setupCell(imageName: image, title: viewModel.comics![indexPath.row].title, subtitle: "Fiyatı: \(String(price))$")
			}
		} else if collectionView.tag == HomeConstant.trendsCollectionViewTag {
			if let image = viewModel.characters?[indexPath.row].thumbnail?.path!,
			   let title = viewModel.characters![indexPath.row].name {
				var subtitle: String = ""
				
				if let items = viewModel.characters![indexPath.row].series?.items {
					for (index,item) in items.enumerated() {
						if index < 2 {
							subtitle += " \(item.name!) \n"
						}
					}
				}
				cell.setupCell(imageName: image, title: title, subtitle: subtitle)
			}
		}
		return cell
	}
}


// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if collectionView.tag == HomeConstant.forYouCollectionViewTag {
			indexOfSelectedCollectionCell = indexPath.row
			performSegue(withIdentifier: HomeConstant.homeToComicPageSegueID, sender: self)
		} else if collectionView.tag == HomeConstant.trendsCollectionViewTag {
			indexOfSelectedCollectionCell = indexPath.row
			performSegue(withIdentifier: HomeConstant.homeToCharPageSegueID, sender: self)
		}
	}
}


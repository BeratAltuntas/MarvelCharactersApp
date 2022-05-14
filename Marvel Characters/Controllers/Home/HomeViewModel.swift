//
//  HomeViewControllerModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import Foundation
import UIKit

// MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol {
	var delegate: HomeViewModelDelegate? { get set }
	var comics: [ComicModelResult]? { get }
	var characters: [CharacterModelResult]? { get }
	
	func load()
	func loadCellContent(collectionView: UICollectionView, Id: String,tag: [Int], index: IndexPath)-> UICollectionViewCell
	func prepareToOpenPage(segue: UIStoryboardSegue, index: Int)
}

// MARK: - HomeViewModelDelegate
protocol HomeViewModelDelegate: AnyObject {
	func setupCollectionViews()
	func reloadCollectionViews()
	func setupNavigationBar()
}

// MARK: - HomeViewModel
final class HomeViewModel {
	weak var delegate: HomeViewModelDelegate?
	
	private var comic: ComicModel?
	private var comicList: [ComicModelResult]?
	
	private var character: CharacterModel?
	private var characterList: [CharacterModelResult]?
	
	func fetchComics(completionHandler: @escaping ([ComicModelResult]) -> Void) {
		NetworkManager.shared.fetchData(endPoint: Config.comicMainUrl + "?", type: ComicModel?.self) { [weak self] result in
			switch result {
			case .success(let response):
				self?.comic = response
				completionHandler(response.data!.results!)
			case .failure(let error):
				print(error)
				break
			}
		}
	}
	
	func fetchCharacters(completionHandler: @escaping ([CharacterModelResult]) -> Void) {
		NetworkManager.shared.fetchData(endPoint: Config.characterMainUrl + "?", type: CharacterModel?.self) { [weak self] result in
			switch result {
			case .success(let response):
				self?.character = response
				completionHandler(response.data!.results!)
			case .failure(let error):
				print(error)
				break
			}
		}
	}
	
	func fetchComicData() {
		fetchComics { [weak self] comics in
			self?.comicList = comics
			DispatchQueue.main.async { [weak self] in
				self?.delegate?.reloadCollectionViews()
			}
		}
	}
	
	func fetchCharacterData() {
		fetchCharacters { [weak self] characters in
			self?.characterList = characters
			DispatchQueue.main.async { [weak self] in
				self?.delegate?.reloadCollectionViews()
			}
		}
	}
}

// MARK: - HomeViewModelExtension
extension HomeViewModel: HomeViewModelProtocol {
	var characters: [CharacterModelResult]? {
		get { characterList }
	}
	
	var comics: [ComicModelResult]? {
		get { comicList }
	}
	
	func load() {
		delegate?.setupCollectionViews()
		delegate?.setupNavigationBar()
		fetchComicData()
		fetchCharacterData()
	}
	
	func loadCellContent(collectionView: UICollectionView,Id: String,tag: [Int],index: IndexPath)-> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Id, for: index) as! ComicsCollectionViewCell
		
		if collectionView.tag == tag[0] {
			var image = comicList?[index.row].thumbnail?.path!
			if ((image?.contains("image_not_available")) != nil) {
				image = comicList?[index.row].images?.first?.path ?? nil
			}
			if let price = comicList?[index.row].prices?[0].price{
				cell.setupCell(imageName: image, title: comicList?[index.row].title, subtitle: "Fiyatı: \(String(price))$")
			}
		} else if collectionView.tag == tag[1] {
			let image = characterList?[index.row].thumbnail?.path!
			let title = characterList?[index.row].name
			var subtitle: String = ""
			
			if let items = characterList?[index.row].series?.items {
				for (index,item) in items.enumerated() {
					if index < 2 {
						subtitle += " \(item.name!) \n"
					}
				}
			}
			cell.setupCell(imageName: image, title: title, subtitle: subtitle)
		}
		return cell
	}
	
	func prepareToOpenPage(segue: UIStoryboardSegue, index: Int) {
		if segue.identifier == HomeConstant.homeToCharPageSegueID {
			let targetVC = segue.destination as! CharacterPageViewController
			targetVC.viewModel = CharacterPageViewModel()
			targetVC.selectedCharacter = characterList?[index]
			
		} else if segue.identifier == HomeConstant.homeToComicPageSegueID {
			let targetVC = segue.destination as! ComicPageViewController
			targetVC.viewModel = ComicPageViewModel()
			targetVC.selectedComic = comicList?[index]
		}
	}
}


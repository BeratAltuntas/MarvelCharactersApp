//
//  HomeViewControllerModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import Foundation

// MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol {
	var delegate: HomeViewModelDelegate? { get set }
	var comics: [ComicModelResult]? { get }
	var characters: [CharacterModelResult]? { get }
	func load()
}

// MARK: - HomeViewModelDelegate
protocol HomeViewModelDelegate: AnyObject {
	func setupCollectionViews()
	func reloadCollectionViews()
	func setupNavigationBar()
	func StartIndicators()
	func StopIndicators()
}

// MARK: - HomeViewModel
final class HomeViewModel {
	weak var delegate: HomeViewModelDelegate?
	
	private var comic: ComicModel?
	private var comicList: [ComicModelResult]?
	
	private var character: CharacterModel?
	private var characterList: [CharacterModelResult]?
	
	func fetchComics(completionHandler: @escaping ([ComicModelResult]) -> Void) {
		let limit = "40"
		NetworkManager.shared.fetchData(endPoint: Config.comicMainUrl + "?" + Config.searchWithLimit + limit + "&", type: ComicModel?.self) { [weak self] result in
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
		let limit = "40"
		NetworkManager.shared.fetchData(endPoint: Config.characterMainUrl + "?" + Config.searchWithLimit + limit + "&", type: CharacterModel?.self) { [weak self] result in
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
				self?.delegate?.StopIndicators()
			}
		}
	}
	
	func fetchCharacterData() {
		fetchCharacters { [weak self] characters in
			self?.characterList = characters
			DispatchQueue.main.async { [weak self] in
				self?.delegate?.reloadCollectionViews()
				self?.delegate?.StopIndicators()
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
		delegate?.StartIndicators()
		delegate?.setupCollectionViews()
		delegate?.setupNavigationBar()
		fetchComicData()
		fetchCharacterData()
	}
}


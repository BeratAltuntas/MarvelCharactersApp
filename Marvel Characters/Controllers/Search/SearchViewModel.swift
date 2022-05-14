//
//  SearchViewControllerModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import Foundation

// MARK: - SearchViewModelProtocol
protocol SearchViewModelProtocol {
	var delegate: SearchViewModelDelegate? { get set }
	var searchCharacter: [CharacterModelResult]? { get }
	var searchComic: [ComicModelResult]?  { get }
	var searchCreator: [CreatorModelResult]? { get }
	
	func SetupUI()
	func fetchCharacter(searchingString: String)
	func fetchComic(searchingString: String)
	func fetchWriter(searchingString: String)
}

// MARK: - SearchViewModelDelegate
protocol SearchViewModelDelegate: AnyObject {
	func setupTableView()
	func reloadTableView()
	func setupNavigationBar()
}
// MARK: - SearchViewModel
final class SearchViewModel {
	weak var delegate: SearchViewModelDelegate?
	var searchCharacter: [CharacterModelResult]?
	var searchComic: [ComicModelResult]?
	var searchCreator: [CreatorModelResult]?
}

// MARK: - SearchViewModelExtension
extension SearchViewModel: SearchViewModelProtocol {
	
	func SetupUI() {
		delegate?.setupNavigationBar()
		delegate?.setupTableView()
	}
	
	func fetchCharacter(searchingString: String) {
		let endpoint = Config.characterMainUrl + "?" + Config.searchCharacterNameStartWith + searchingString + "&"
		NetworkManager.shared.fetchData(endPoint: endpoint, type: CharacterModel?.self) { [weak self] result in
			switch result {
			case .success(let response):
				self?.searchCharacter = response.data?.results
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func fetchComic(searchingString: String) {
		let endpoint = Config.comicMainUrl + "?" + Config.searchComicTitleStartsWith + searchingString + "&"
		NetworkManager.shared.fetchData(endPoint: endpoint, type: ComicModel?.self) { [weak self] result in
			switch result {
			case .success(let response):
				self?.searchComic = response.data?.results
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func fetchWriter(searchingString: String) {
		let endpoint = Config.creatorMainUrl + "?" + Config.searchCreatorWithFirstName + searchingString + "&"
		NetworkManager.shared.fetchData(endPoint: endpoint, type: CreatorModel?.self) { [weak self] result in
			switch result {
			case .success(let response):
				self?.searchCreator = response.data?.results
			case .failure(let error):
				print(error)
			}
		}
	}
}

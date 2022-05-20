//
//  FavoritesViewControllerModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import Foundation

// MARK: - FavoriteViewModelProtocol
protocol FavoritesViewModelProtocol {
	var delegate: FavoritesViewModelDelegate? { get set }
	var comics: [ComicModelResult]! { get }
	var characters: [CharacterModelResult]! { get }
	func LoadScreen()
}

// MARK: - FavoriteViewModelDelegate
protocol FavoritesViewModelDelegate: AnyObject {
	func SetupUI()
	func SetupCell()
	func ReloadCollectionView()
}

// MARK: - FavoriteViewModel
final class FavoritesViewModel {
	weak var delegate: FavoritesViewModelDelegate?
	var comicsList = [ComicModelResult]()
	var charactersList = [CharacterModelResult]()
	func GetLikedComics() {
		guard let userUid = FirebaseAuthManager.shared.GetUserUid() else { return }
		FireBaseDatabaseManager.shared.GetUsersLikedComics(userUid: userUid) { success, ids in
			if success {
				for id in ids {
					FireBaseDatabaseManager.shared.GetComic(withIds: id) {[weak self] successComic, result in
						if successComic {
							self?.comicsList.append(result)
							self?.delegate?.ReloadCollectionView()
						}
					}
				}
			}
		}
	}
	func GetLikedCharacters() {
		guard let userUid = FirebaseAuthManager.shared.GetUserUid() else { return }
		FireBaseDatabaseManager.shared.GetUsersLikedCharacters(userUid: userUid) { success, result in
			if success {
				
			}
		}
	}
}

// MARK: - FavoriteViewModelExtension
extension FavoritesViewModel: FavoritesViewModelProtocol {
	var comics: [ComicModelResult]! {
		comicsList
	}
	var characters: [CharacterModelResult]! {
		charactersList
	}
	
	func LoadScreen() {
		delegate?.SetupCell()
		delegate?.SetupUI()
		GetLikedComics()
		//GetLikedCharacters()
		//delegate?.ReloadCollectionView()
	}
}

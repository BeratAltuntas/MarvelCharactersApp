//
//  CharacterPageModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 1.05.2022.
//

import Foundation

// MARK: - CharacterPageViewModelProtocol
protocol CharacterPageViewModelProtocol {
	var delegate: CharacterPageViewModelDelegate? { get set }
	func Load()
	func CharacterIsLiked(comicId: Int, userUid: String)
	func LikeCharacter(withCharacterId: Int, user: User)
}

// MARK: - CharacterPageViewModelDelegate
protocol CharacterPageViewModelDelegate: AnyObject {
	func SetupTableViews()
	func ReloadTableViews()
	func SetPageAttiributes()
	func ChangeLikedImageViewImage()
}

// MARK: - CharacterPageViewModel
final class CharacterPageViewModel {
	weak var delegate: CharacterPageViewModelDelegate?
	
	func SetLikedCharacter(user: User) {
		FireBaseDatabaseManager.shared.SetUsersLikedCharacters(user: user) {[weak self] success in
			if success {
				self?.delegate?.ChangeLikedImageViewImage()
			}
		}
	}
}

// MARK: - Extension CharacterPageViewModel
extension CharacterPageViewModel: CharacterPageViewModelProtocol {
	
	func Load() {
		delegate?.SetupTableViews()
		delegate?.SetPageAttiributes()
		delegate?.ReloadTableViews()
	}
	func LikeCharacter(withCharacterId: Int, user: User) {
		FireBaseDatabaseManager.shared.GetUsersLikedCharacters(userUid: user.uid!) { [weak self] (success, result) in
			if success {
				var itIsLikedBefore = false
				for i in 0..<result.count {
					if result[i] == withCharacterId {
						FireBaseDatabaseManager.shared.DeleteUsersLikedCharacter(withCharId: withCharacterId) { _ in }
						itIsLikedBefore = true
						self?.delegate?.ChangeLikedImageViewImage()
						break
					}
				}
				if !itIsLikedBefore {
					user.charactersIds?.append(contentsOf: result)
					self?.SetLikedCharacter(user: user)
				}
			} else {
				if result.first == -1 {
					self?.SetLikedCharacter(user: user)
				}
			}
		}
	}
	func CharacterIsLiked(comicId: Int, userUid: String) {
		FireBaseDatabaseManager.shared.GetUsersLikedCharacters(userUid: userUid) { [weak self] success, result in
			if success {
				for res in result {
					if res == comicId {
						self?.delegate?.ChangeLikedImageViewImage()
					}
				}
			}
		}
	}
}

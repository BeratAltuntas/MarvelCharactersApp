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
		FireBaseDatabaseManager.shared.SetUserCharacters(user: user) {[weak self] success in
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
		FireBaseDatabaseManager.shared.GetUserCharacters(userUid: user.uid!) { [weak self] (success, result) in
			if success {
				var itIsLikedBefore = false
				for i in 0..<result.count {
					if result[i] == withCharacterId {
						var array = result
						array.remove(at: i)
						let tempDeletingUser = User(uId: user.uid, comicResult: [], characterResult: array)
						FireBaseDatabaseManager.shared.DeleteUserCharacter(user: tempDeletingUser)
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
		FireBaseDatabaseManager.shared.GetUserCharacters(userUid: userUid) { [weak self] success, result in
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

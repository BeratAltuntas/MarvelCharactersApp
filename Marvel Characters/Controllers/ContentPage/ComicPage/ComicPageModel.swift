//
//  ComicPageModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 1.05.2022.
//

import Foundation

// MARK: - ComicPageViewModelProtocol
protocol ComicPageViewModelProtocol {
	var delegate: ComicPageViewModelDelegate? { get set }
	
	func loadComicAttiributes(comic: ComicModelResult?)
	func ComicIsLiked(comicId: Int, userUid: String)
	func LikeComic(withComicId: Int, user: User)
}

// MARK: - ComicPageViewModelDelegate
protocol ComicPageViewModelDelegate: AnyObject {
	func setupTableViews()
	func setupUI()
	func reloadTableViews()
	func ChangeLikedImageViewImage(likeComic: Bool)
}

// MARK: - ComicPageViewModel
final class ComicPageViewModel {
	internal weak var delegate: ComicPageViewModelDelegate?
	
	func SetLikedComic(user: User) {
		FireBaseDatabaseManager.shared.SetUserComics(user: user) { [weak self] success in
			if success {
				self?.delegate?.ChangeLikedImageViewImage(likeComic: true)
			}
		}
	}
}

// MARK: - Extension ComicPageViewModel
extension ComicPageViewModel: ComicPageViewModelProtocol {
	func ComicIsLiked(comicId: Int, userUid: String) {
		FireBaseDatabaseManager.shared.GetUsersLikedComics(userUid: userUid) { [weak self] success, result in
			if success {
				for res in result {
					if res == comicId {
						self?.delegate?.ChangeLikedImageViewImage(likeComic: true)
					}
				}
			} else if result.first == -1 {
				self?.delegate?.ChangeLikedImageViewImage(likeComic: false)
			}
		}
	}
	func LikeComic(withComicId: Int, user: User) {
		FireBaseDatabaseManager.shared.GetUsersLikedComics(userUid: user.uid!) { [weak self] (success, result) in
			if success {
				var itIsLikedBefore = false
				for i in 0..<result.count {
					if result[i] == withComicId {
						FireBaseDatabaseManager.shared.DeleteUserLikedComic(deletingId: withComicId) { success in }
						itIsLikedBefore = true
						self?.delegate?.ChangeLikedImageViewImage(likeComic: false)
						break
					}
				}
				if !itIsLikedBefore {
					user.comicsIds?.append(contentsOf: result)
					self?.SetLikedComic(user: user)
				}
			} else {
				if result.first == -1 {
					self?.SetLikedComic(user: user)
				}
			}
		}
	}
	
	func loadComicAttiributes(comic: ComicModelResult?) {
		delegate?.setupTableViews()
		delegate?.setupUI()
	}
}




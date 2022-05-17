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
	func ChangeLikedImageViewImage()
}

// MARK: - ComicPageViewModel
final class ComicPageViewModel {
	weak var delegate: ComicPageViewModelDelegate?
}

// MARK: - Extension ComicPageViewModel
extension ComicPageViewModel: ComicPageViewModelProtocol {
	func ComicIsLiked(comicId: Int, userUid: String) {
		FireBaseDatabaseManager.shared.GetUserComics(userUid: userUid) { [weak self] success, result in
			if success {
				for res in result {
					if res == comicId {
						self?.delegate?.ChangeLikedImageViewImage()
					}
				}
			}
		}
	}
	
	func LikeComic(withComicId: Int, user: User) {
		FireBaseDatabaseManager.shared.GetUserComics(userUid: user.uid!) { success, result in
			if success {
				user.comicsIds?.append(contentsOf: result)
				FireBaseDatabaseManager.shared.SetUserComics(user: user) {[weak self] success in
					if success {
						self?.delegate?.ChangeLikedImageViewImage()
					}
				}
			}
		}
	}
	
	func loadComicAttiributes(comic: ComicModelResult?) {
		delegate?.setupTableViews()
		delegate?.setupUI()
	}
}




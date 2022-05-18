//
//  UserViewControllerModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//
import Foundation
import Kingfisher

typealias UserViewCompletion = (_ success: Bool, _ user: User) -> Void

// MARK: - UserViewModelProtocol
protocol UserViewModelProtocol {
	var delegate: UserViewModelDelegate? { get set }
	var user: User? { get }
	
	func LoadUI()
	func LoadUserInfos(completion: @escaping UserViewCompletion)
	func DownloadUserImage(urlString: String?, completion: @escaping CompletionHandlerImage)
}

// MARK: - UserViewModelDelegate
protocol UserViewModelDelegate: AnyObject {
	func SetupUI()
	func ReloadTableView()
}

// MARK: - UserViewModel
final class UserViewModel {
	
	
	weak var delegate: UserViewModelDelegate?
	var userViewModel: User?
}

// MARK: - UserViewModelExtension
extension UserViewModel: UserViewModelProtocol {
	
	var user: User? {
		userViewModel
	}
	
	func LoadUserInfos(completion: @escaping UserViewCompletion) {
		FireBaseDatabaseManager.shared.GetUserInDatabase(withUid: FirebaseAuthManager.shared.GetUserUid()!) { [weak self] (success, result) in
			if success {
				self?.userViewModel = result
				completion(true, result)
			}
		}
	}
	func DownloadUserImage(urlString: String?, completion: @escaping CompletionHandlerImage) {
		guard let urlString = urlString else { return }
		guard let url = URL(string: urlString) else { return }
		let resource = ImageResource(downloadURL: url)
		KingfisherManager.shared.retrieveImage(with: resource) { result in
			switch result {
			case .success(let value):
				completion(true, value.image)
			case .failure(let error):
				print("Error: \(error)")
				completion(false, UIImage(systemName: "person.fill")!)
			}
		}
	}
	func LoadUI() {
		delegate?.SetupUI()
	}
}

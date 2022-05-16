//
//  UserSettingsViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//
import Foundation
import Kingfisher

typealias CompletionHandlerImage = (_ success: Bool, _ image: UIImage)-> Void

// MARK: - UserSettingsViewModelProtocol
protocol UserSettingsViewModelProtocol {
	var delegate: UserSettingsViewModelDelegate? { get set }
	var image: UIImage? { get }
	
	func UpdateUserInfo(user: User!, imageData: Data)
	func DownloadImage(urlString: String?, completion: @escaping CompletionHandlerImage)
}

// MARK: - UserSettingsViewModelDelegate
protocol UserSettingsViewModelDelegate: AnyObject {
	var isImageSet: Bool { get }
	func DissmissToRootController()
	func SetImage()
	
}

// MARK: - UserSettingsViewModel
final class UserSettingsViewModel {
	weak var delegate: UserSettingsViewModelDelegate?
	private var uID: String!
	private var imageViewModel: UIImage?
	private var photoUrl: String!
	var currentUserViewModel: User!
}

// MARK: - Extension: UserSettingsViewModelProtocol
extension UserSettingsViewModel: UserSettingsViewModelProtocol {
	var image: UIImage? {
		imageViewModel
	}
	func UpdateUserInfo(user: User!, imageData: Data) {
		guard let imageset = delegate?.isImageSet else { return }
		if imageset {
			FirebaseStorageManager.shared.UploadImageToFirebaseStorage(uId: user.uid!, imageData: imageData) { complete, imageStringPath in
				if complete {
					let tempUser = User(uId: user.uid, email: user.email, profileImageLink: imageStringPath, namesurname: user.namesurname, birthdate: user.birthdate, city: user.city, gender: user.gender)
					FireBaseDatabaseManager.shared.UpdateUserInDatabase(withUser: tempUser) {[weak self] success in
						if success {
							self?.delegate?.DissmissToRootController()
						}
					}
				}
			}
			
		} else {
			let tempUser = User(uId: user.uid, email: user.email, profileImageLink: "", namesurname: user.namesurname, birthdate: user.birthdate, city: user.city, gender: user.gender)
			FireBaseDatabaseManager.shared.UpdateUserInDatabase(withUser: tempUser) {[weak self] success in
				if success {
					self?.delegate?.DissmissToRootController()
				}
			}
		}
	}
	
	func DownloadImage(urlString: String?, completion: @escaping CompletionHandlerImage) {
		guard let urlString = urlString else { return }
		guard let url = URL(string: urlString) else { return }
		let resource = ImageResource(downloadURL: url)
		KingfisherManager.shared.retrieveImage(with: resource) { result in
			switch result {
			case .success(let value):
				completion(true, value.image)
			case .failure(let error):
				print("Error: \(error)")
			}
		}
	}
}

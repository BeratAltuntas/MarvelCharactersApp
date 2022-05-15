//
//  UserSettingsViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//
import FirebaseAuth
import FirebaseStorage
import Foundation

// MARK: - UserSettingsViewModelProtocol
protocol UserSettingsViewModelProtocol {
	var delegate: UserSettingsViewModelDelegate? { get set }
	var name: String? { get }
	var image: UIImage? { get }
	var city: String? { get }
	var birthdate: String? { get }
	var email: String? { get }
	
	func UpdateUserInfo(name: String, image: UIImage, city: String, birthdate: String, email: String)
	func getUserInfos()
}

// MARK: - UserSettingsViewModelDelegate
protocol UserSettingsViewModelDelegate: AnyObject {
	func DissmissToRootController()
}

// MARK: - UserSettingsViewModel
final class UserSettingsViewModel {
	weak var delegate: UserSettingsViewModelDelegate?
	private var uID: String!
	private var photoUrl: URL!
	var userName: String?
	var userImage: UIImage?
	var userCity: String?
	var userBirthdate: String?
	var userEmail: String?
	
	func UpdateStorageUserImage(image: UIImage) {
		guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
		let storageRef = Storage.storage().reference(forURL: Config.firebaseStorageReferenceUrl)
		let profileRef = storageRef.child(Config.firebaseStorageReferenceMainChild).child(uID)
		
		let metaData = StorageMetadata()
		metaData.contentType = "image/jpg"
		profileRef.putData(imageData, metadata: metaData) { (storageMetaData, error) in
			if error != nil {
				print(error!.localizedDescription)
				return
			}
		}
	}
}

// MARK: - Extension: UserSettingsViewModelProtocol
extension UserSettingsViewModel: UserSettingsViewModelProtocol {
	var name: String? {
		userName
	}
	
	var image: UIImage? {
		userImage
	}
	
	var city: String? {
		userCity
	}
	
	var birthdate: String? {
		userBirthdate
	}
	
	var email: String? {
		userEmail
	}
	
	func getUserInfos() {
		let user = Auth.auth().currentUser
		if let user = user {
			uID = user.uid
			userName = user.displayName
			userEmail = user.email
			photoUrl = user.photoURL
		}
	}
	
	func UpdateUserInfo(name: String,image: UIImage, city: String, birthdate: String, email: String) {
		FireBaseDatabaseManager.shared.UpdateUserInDatabase(withUId: uID, name: name, email: email, profileImage: "image", birthdate: birthdate, city: city, gender: "gender", password: "") {[weak self] success in
			if success {
				self?.delegate?.DissmissToRootController()
			}
		}
//
//		let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//		if !name.isEmpty {
//			changeRequest?.displayName = name
//		}
//		UpdateStorageUserImage(image: image)
//
//		changeRequest?.commitChanges(completion: { [weak self] error in
//			if error == nil {
//				self?.delegate?.DissmissToRootController()
//			}
//		})
	}
}

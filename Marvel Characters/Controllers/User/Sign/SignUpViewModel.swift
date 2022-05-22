//
//  CreateUserViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//
import Foundation
import UIKit.UIImage

// MARK: - SignUpViewModelProtocol
protocol SignUpViewModelProtocol {
	var delegate: SignUpViewModelDelegate? { get set }
	
	func CreateUser(name: String, email: String, imageData: Data, password: String)
	func CreateUserInDatabase(user: User)
	func UploadUserImageInStorage(uId: String, imageData: Data, completion: @escaping CompletionStorage)
}

// MARK: - SignUpViewModelDelegate
protocol SignUpViewModelDelegate: AnyObject {
	func Dissmiss()
	func ImageToData(image: UIImage)-> Data
}

// MARK: - SignUpViewModel
final class SignUpViewModel {
	internal weak var delegate: SignUpViewModelDelegate?
}

// MARK: - Extension: SignUpViewModelProtocol
extension SignUpViewModel: SignUpViewModelProtocol {
	func CreateUser(name: String, email: String, imageData: Data, password: String) {
		FirebaseAuthManager.shared.CreateUser(email: email, password: password) { [weak self] (success, uId) in
			if success {
				self?.UploadUserImageInStorage(uId: uId, imageData: imageData, completion: { [weak self] complete, imageStringPath in
					if complete {
						let tempUser = User(uId: uId, email: email, profileImageLink: imageStringPath, namesurname: name, birthdate: "", city: "", gender: "")
						self?.CreateUserInDatabase(user: tempUser)
					}
				})
			}
		}
	}
	func CreateUserInDatabase(user: User) {
		FireBaseDatabaseManager.shared.CreateUserInDatabase(user: user) { [weak self] (success) in
			if success {
				self?.delegate?.Dissmiss()
			}
		}
	}
	func UploadUserImageInStorage(uId: String, imageData: Data, completion: @escaping CompletionStorage) {
		FirebaseStorageManager.shared.UploadImageToFirebaseStorage(uId: uId, imageData: imageData) { result, imageStringPath in
			completion(result, imageStringPath)
		}
	}
}

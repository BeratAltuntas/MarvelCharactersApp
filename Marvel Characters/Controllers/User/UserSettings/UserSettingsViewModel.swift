//
//  UserSettingsViewModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//
import FirebaseAuth
import Foundation

// MARK: - UserSettingsViewModelProtocol
protocol UserSettingsViewModelProtocol {
	var delegate: UserSettingsViewModelDelegate? { get set }
	func UpdateUserInfo(name: String, city: String, birthdate: String, email: String)
}

// MARK: - UserSettingsViewModelDelegate
protocol UserSettingsViewModelDelegate: AnyObject {
	func Dissmiss()
}

// MARK: - UserSettingsViewModel
final class UserSettingsViewModel {
	weak var delegate: UserSettingsViewModelDelegate?
}

// MARK: - Extension: UserSettingsViewModelProtocol
extension UserSettingsViewModel: UserSettingsViewModelProtocol {
	func UpdateUserInfo(name: String, city: String, birthdate: String, email: String) {
		let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
		changeRequest?.displayName = name
		changeRequest?.commitChanges(completion: { [weak self] error in
			if error == nil {
				self?.delegate?.Dissmiss()
			}
		})
	}
}

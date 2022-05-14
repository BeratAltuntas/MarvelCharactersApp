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
	func UpdateUserInfo()
}

// MARK: - UserSettingsViewModelDelegate
protocol UserSettingsViewModelDelegate: AnyObject {
	
}

// MARK: - UserSettingsViewModel
final class UserSettingsViewModel {
	weak var delegate: UserSettingsViewModelDelegate?
}

// MARK: - Extension: UserSettingsViewModelProtocol
extension UserSettingsViewModel: UserSettingsViewModelProtocol {
	func UpdateUserInfo() {
		
	}
}

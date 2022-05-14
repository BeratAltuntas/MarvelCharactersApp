//
//  UserSettingsViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import UIKit

// MARK: - UserSettingsViewController
final class UserSettingsViewController: BaseViewController {

	var viewModel: UserSettingsViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	@IBOutlet weak var textFieldNameSurname: UITextField!
	@IBOutlet weak var textFieldCity: UITextField!
	@IBOutlet weak var datePickerBirthdate: UIDatePicker!
	@IBOutlet weak var textFieldEmail: UITextField!
	override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	@IBAction func UpdateUserInfo_TUI(_ sender: UIButton) {
		
	}
}

// MARK: - Extension: UserSettingsViewModelDelegate
extension UserSettingsViewController: UserSettingsViewModelDelegate {
	
}


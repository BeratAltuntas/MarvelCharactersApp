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
		if let name = textFieldNameSurname.text,
		   let city = textFieldCity.text,
		   let date = datePickerBirthdate?.date,
		   let email = textFieldEmail.text {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd/MM/YY"
			let birthdate = dateFormatter.string(from: date)
			viewModel.UpdateUserInfo(name: name, city: city, birthdate: birthdate, email: email)
		}
	}
}

// MARK: - Extension: UserSettingsViewModelDelegate
extension UserSettingsViewController: UserSettingsViewModelDelegate {
	func Dissmiss() {
		_ = navigationController?.popToRootViewController(animated: true)
	}
}


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
	@IBOutlet weak var imageViewProfileImage: UIImageView!
	@IBOutlet weak var textFieldNameSurname: UITextField!
	@IBOutlet weak var textFieldCity: UITextField!
	@IBOutlet weak var datePickerBirthdate: UIDatePicker!
	@IBOutlet weak var textFieldEmail: UITextField!
	
	var currentImage: UIImage!
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.getUserInfos()
		LoadUserInfo()
	}
	func LoadUserInfo() {
		imageViewProfileImage.image = viewModel.image
		textFieldNameSurname.text = viewModel.name
		textFieldCity.text = viewModel.city
		textFieldEmail.text = viewModel.email
		
//		let dateFormatter = DateFormatter()
//		dateFormatter.dateFormat = "dd/MM/YY"
//		let birthdate = dateFormatter.date(from: viewModel.birthdate ?? "")
//		datePickerBirthdate.setDate(birthdate ?? , animated: true)
	}
	
	@IBAction func selecetImage_TUI(_ sender: UIButton) {
		OpenImagePicker()
	}
	
	@IBAction func UpdateUserInfo_TUI(_ sender: UIButton) {
		if let name = textFieldNameSurname.text,
		   let _ = imageViewProfileImage.image,
		   let city = textFieldCity.text,
		   let date = datePickerBirthdate?.date,
		   let email = textFieldEmail.text {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd/MM/YY"
			let birthdate = dateFormatter.string(from: date)
			viewModel.UpdateUserInfo(name: name,image: currentImage, city: city, birthdate: birthdate, email: email)
		}
	}
}

// MARK: - Extension: UserSettingsViewModelDelegate
extension UserSettingsViewController: UserSettingsViewModelDelegate {
	func DissmissToRootController() {
		_ = navigationController?.popToRootViewController(animated: true)
	}
}

extension UserSettingsViewController: UINavigationControllerDelegate {
	
}

extension UserSettingsViewController: UIImagePickerControllerDelegate {
	func OpenImagePicker() {
		let imagePicker = UIImagePickerController()
		imagePicker.allowsEditing = true
		imagePicker.delegate = self
		imagePicker.sourceType = .photoLibrary
		present(imagePicker, animated: true)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		// image is selected
		dismiss(animated: true)
		guard let image = info[.editedImage] as? UIImage else{return}
		currentImage = image
		imageViewProfileImage.image = currentImage
	}
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		// image selecting is canceled
		dismiss(animated: true)
		print("image cancel")
	}
}


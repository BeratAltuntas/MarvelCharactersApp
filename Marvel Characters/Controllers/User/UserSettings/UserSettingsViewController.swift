//
//  UserSettingsViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import UIKit

// MARK: - UserSettingsViewController
final class UserSettingsViewController: BaseViewController {
	internal var viewModel: UserSettingsViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	
	@IBOutlet private weak var imageViewProfileImage: UIImageView!
	@IBOutlet private weak var textFieldNameSurname: UITextField!
	@IBOutlet private weak var textFieldEmail: UITextField!
	@IBOutlet private weak var textFieldCity: UITextField!
	@IBOutlet private weak var datePickerBirthdate: UIDatePicker!
	@IBOutlet private weak var segmentControllerGender: UISegmentedControl!
	
	private var currentImage = UIImage(systemName: "person.fill" )
	private var user: User!
	private var imageIsSet = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if FirebaseAuthManager.shared.IsUserSignedIn() {
			GetUserInDatabase()
		}
	}
	func GetUserInDatabase() {
		FireBaseDatabaseManager.shared.GetUserInDatabase(withUid: FirebaseAuthManager.shared.GetUserUid()!) {[weak self] success, result in
			if success {
				self?.user = result
				self?.viewModel.DownloadImage(urlString: result.profileImageLink, completion: {[weak self] success, image in
					if success {
						self?.currentImage = image
						self?.LoadUserInfo(image: image)
					}
				})
				self?.LoadUserInfo(image: self!.currentImage!)
			}
		}
	}
	func LoadUserInfo(image: UIImage) {
		imageViewProfileImage.image = image
		textFieldNameSurname.text = user.namesurname
		textFieldCity.text = user.city
		textFieldEmail.text = user.email
		segmentControllerGender.selectedSegmentIndex = user.gender == "Erkek" ? 1 :  0
		if let birthdate = user.birthdate {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd-MM-yyyy"
			let date = dateFormatter.date(from:birthdate)
			if let date = date {
				datePickerBirthdate.setDate(date, animated: true)
			}
		}
	}
	@IBAction func selecetImage_TUI(_ sender: UIButton) {
		OpenImagePicker()
	}
	@IBAction func UpdateUserInfo_TUI(_ sender: UIButton) {
		if let name = textFieldNameSurname.text,
		   let city = textFieldCity.text,
		   let date = datePickerBirthdate?.date,
		   let email = textFieldEmail.text {
			let gender = segmentControllerGender.titleForSegment(at: segmentControllerGender.selectedSegmentIndex)
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd/MM/yyyy"
			let birthdate = dateFormatter.string(from: date)
			let imgData = ImageToData(image: currentImage!)
			let tempUser = User(uId: user.uid, email: email, profileImageLink: "", namesurname: name, birthdate: birthdate, city: city, gender: gender)
			viewModel.UpdateUserInfo(user: tempUser, imageData: imgData)
		}
	}
	@IBAction func SignOut_TUI(_ sender: Any) {
		viewModel.SignOut()
	}
}

// MARK: - Extension: UserSettingsViewModelDelegate
extension UserSettingsViewController: UserSettingsViewModelDelegate {
	var isImageSet: Bool {
		imageIsSet
	}
	
	func SetImage() {
		imageViewProfileImage.image = viewModel.image
	}
	func DissmissToRootController() {
		_ = navigationController?.popToRootViewController(animated: true)
	}
}

// MARK: - Extension: UINavigationControllerDelegate
extension UserSettingsViewController: UINavigationControllerDelegate { }

// MARK: - Extension: UIImagePickerControllerDelegate
extension UserSettingsViewController: UIImagePickerControllerDelegate {
	func OpenImagePicker() {
		let imagePicker = UIImagePickerController()
		imagePicker.allowsEditing = true
		imagePicker.delegate = self
		imagePicker.sourceType = .photoLibrary
		present(imagePicker, animated: true)
	}
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		dismiss(animated: true)
		guard let image = info[.editedImage] as? UIImage else{return}
		currentImage = image
		imageIsSet = true
		imageViewProfileImage.image = currentImage
	}
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true)
	}
}

// MARK: - Extension: UIScrollViewDelegate
extension UserSettingsViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		view.endEditing(true)
	}
}


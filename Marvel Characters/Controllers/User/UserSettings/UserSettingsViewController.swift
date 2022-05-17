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
	@IBOutlet weak var segmentControllerGender: UISegmentedControl!
	@IBOutlet weak var textFieldEmail: UITextField!
	
	var currentImage = UIImage(systemName: "person.fill" )
	var user: User!
	var imageIsSet = false
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		print(true)
	}
	
	func LoadUserInfo(image: UIImage) {
		imageViewProfileImage.image = image
		textFieldNameSurname.text = user.namesurname
		textFieldCity.text = user.city
		textFieldEmail.text = user.email
		segmentControllerGender.selectedSegmentIndex = user.gender == "Erkek" ? 1 :  0
		if let birthdate = user.birthdate {
			do {
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "dd-MM-yyyy"
				let date = try dateFormatter.date(from:birthdate)
				if let date = date {
					datePickerBirthdate.setDate(date, animated: true)
				}
			} catch {
				print(error)
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
		if viewModel.SignOut() {
			DissmissToRootController()
		}
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

extension UserSettingsViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		view.endEditing(true)
	}
}


//
//  CreateUserViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.
//

import UIKit

// MARK: - SignUpViewController
final class SignUpViewController: BaseViewController {
	
	var viewModel: SignUpViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	private var currentImage: UIImage!
	@IBOutlet weak var imageViewUserProfile: UIImageView!
	@IBOutlet weak var textFieldNameSurname: UITextField!
	@IBOutlet weak var textFieldEmail: UITextField!
	@IBOutlet weak var textFieldPassword: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
		let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		imageViewUserProfile.isUserInteractionEnabled = true
		imageViewUserProfile.addGestureRecognizer(imageTapGestureRecognizer)
		
		let closeKeyboardGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DissmissKeyboard))
		view.addGestureRecognizer(closeKeyboardGestureRecognizer)
	}
	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		OpenImagePicker()
	}
	@objc func DissmissKeyboard() {
		view.endEditing(true)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == UserViewConstants.signInViewControllerId {
			let targetVC = segue.destination as! SignInViewController
			targetVC.viewModel = SignInViewModel()
		}
	}
	@IBAction func SignUp_TUI(_ sender: Any) {
		if let name = textFieldNameSurname.text,
		   let email = textFieldEmail.text,
		   let password = textFieldPassword.text {
			if email.contains("@") && password.count >= 8 {
				let imgData = ImageToData(image: imageViewUserProfile.image!)
				viewModel.CreateUser(name: name, email: email, imageData: imgData, password: password)
			}
		}
	}
	
	@IBAction func SignUpWithGoogle_TUI(_ sender: Any) {
	}
}

// MARK: - Extension: SignUpViewModelDelegate
extension SignUpViewController: SignUpViewModelDelegate {
	func Dissmiss() {
		_ = navigationController?.popViewController(animated: true)
	}
}

// MARK: - Extension: UINavigationControllerDelegate
extension SignUpViewController: UINavigationControllerDelegate {
	
}

// MARK: - Extension: UIImagePickerControllerDelegate
extension SignUpViewController: UIImagePickerControllerDelegate {
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
		imageViewUserProfile.image = currentImage
	}
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		// image selecting is canceled
		dismiss(animated: true)
	}
}

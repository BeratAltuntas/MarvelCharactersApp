//
//  FirebaseAuthManager.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 15.05.2022.
//
import FirebaseAuth
import Foundation


// MARK: - FirebaseAuthManager
final class FirebaseAuthManager {
	typealias CompletionHandler = (_ success: Bool, _ uId: String) -> Void
	
	static let shared = FirebaseAuthManager()
	
	
	func IsUserSignedIn()-> Bool {
		if Auth.auth().currentUser == nil{
			return false
		}
		return true
	}
	
	func SignIn(withEmail email: String, password: String, completion: @escaping CompletionHandler) {
		Auth.auth().signIn(withEmail: email, password: password) { result, error in
			if error == nil {
				completion(true, result!.user.uid)
			}
		}
	}
	
	func SignOut() {
		let firebaseAuth = Auth.auth()
		do {
			try firebaseAuth.signOut()
		} catch let signOutError as NSError {
			print("Error signing out: %@", signOutError)
		}
	}
	
	func ChangeUserNameAndImage(name: String, stringImageUrl: String) {
		let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
		changeRequest?.displayName = name
		changeRequest?.photoURL = URL(string: stringImageUrl)
		changeRequest?.commitChanges { error in
			if error != nil {
				print("error: ",error?.localizedDescription ?? "")
			}
		}
	}
	
	func ChangeUserEmail(email: String) {
		Auth.auth().currentUser?.updateEmail(to: email) { error in
			if error != nil {
				print("error: ",error?.localizedDescription ?? "")
			}
		}
	}
	
	func CreateUser(email: String, password: String, completion: @escaping CompletionHandler) {
		Auth.auth().createUser(withEmail: email, password: password) { result, error in
			if error != nil {
				return
			}
			completion(true, result!.user.uid)
		}
	}
	
	func GetUserUid()-> String? {
		let user = Auth.auth().currentUser
		if let user = user {
			return user.uid
		}
		return ""
	}
	
	func GetUserEmail()-> String? {
		let user = Auth.auth().currentUser
		if let user = user {
			return user.email
		}
		return ""
	}
}

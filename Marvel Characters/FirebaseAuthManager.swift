//
//  FirebaseAuthManager.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 15.05.2022.
//
import FirebaseAuth
import Foundation

typealias CompletionHandler = (_ success: Bool, _ uId: String) -> Void
// MARK: - FirebaseAuthManager
final class FirebaseAuthManager {
	static let shared = FirebaseAuthManager()
	// MARK: SignIn
	func SignIn(withEmail email: String, password: String, completion: @escaping CompletionHandler) {
		Auth.auth().signIn(withEmail: email, password: password) { result, error in
			if error == nil {
				completion(true, result!.user.uid)
			}
		}
	}
	// MARK: CreateUser
	func CreateUser(email: String, password: String, completion: @escaping CompletionHandler) {
		Auth.auth().createUser(withEmail: email, password: password) { result, error in
			if error != nil {
				return
			}
			completion(true, result!.user.uid)
		}
	}
}

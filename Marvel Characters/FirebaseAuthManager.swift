//
//  FirebaseAuthManager.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 15.05.2022.
//
import FirebaseAuth
import Foundation

typealias CompletionHandler = (_ result: Bool, _ uId: String) -> Void

final class FirebaseAuthManager {
	static let shared = FirebaseAuthManager()
	
	func CreateUser(email: String, password: String, completion: @escaping CompletionHandler) {
		Auth.auth().createUser(withEmail: email, password: password) { result, error in
			if error != nil {
				return
			}
			completion(true, result!.user.uid)
		}
	}
}

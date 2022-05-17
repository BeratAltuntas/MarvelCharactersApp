//
//  FirebaseDatabaseManager.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 15.05.2022.
//
import FirebaseDatabase
import Foundation

typealias Databasecompletion = (_ success: Bool) -> Void
typealias GetUserCompletionHandler = (_ success: Bool, _ result: User) -> Void
typealias CompletionGetComic = (_ success: Bool, _ result: [Int])-> Void


final class FireBaseDatabaseManager {
	static let shared = FireBaseDatabaseManager()
	
	func UpdateUserInDatabase(withUser user: User, completion: @escaping Databasecompletion) {
		guard let uId = user.uid else { return }
		Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(uId).updateChildValues(user.userDictionary) { (error, databaseRef) in
			completion(true)
		}
	}
	
	func CreateUserInDatabase(user: User, completion: @escaping Databasecompletion) {
		guard let uId = user.uid else { return }
		Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(uId).updateChildValues(user.userDictionary) { (error, databaseRef) in
			completion(true)
		}
	}
	
	func GetUserInDatabase(withUid uId: String, completion: @escaping GetUserCompletionHandler ) {
		let ref = Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(uId)
		
		ref.observeSingleEvent(of: .value) { result in
			
			if result.exists() {
				
				let value = result.value as? NSDictionary
				let data = value as? [String : String]
				if data != nil {
					let user = User(data: data)
					completion(true,user)
				} else {
					FirebaseAuthManager.shared.SignOut()
				}
			}
		}
	}
	
	func GetUserComics(userUid: String, completion: @escaping CompletionGetComic) {
		let ref = Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(userUid)
		
		ref.observeSingleEvent(of: .value) { result in
			let value = result.value as? NSDictionary
			let data = value?["comicsIds"] as? [Int]
			if data != nil {
				guard let ids = data else { return completion(false,[]) }
				completion(true, ids)
			}
		}
	}
	
	func SetUserComics(user: User, completion: @escaping Databasecompletion) {
		guard let uid = user.uid else { return }
		Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(uid).updateChildValues(user.userComicDictionary) { (error, databaseRef) in
			completion(true)
		}
	}
	
	func GetUserComic(withComicId: String, userUid: String) {
		
	}
}

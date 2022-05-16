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

final class FireBaseDatabaseManager {
	static let shared = FireBaseDatabaseManager()
	
	func GetUserInDatabase(withUId uId: String) {
		
	}
	
	func UpdateUserInDatabase(withUser user: User, completion: @escaping Databasecompletion) {
		guard let uId = user.uid else { return }
		Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(uId).updateChildValues(user.dictionary) { (error, databaseRef) in
			completion(true)
		}
	}
	
	func CreateUserInDatabase(user: User, completion: @escaping Databasecompletion) {
		guard let uId = user.uid else { return }
		Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(uId).updateChildValues(user.dictionary) { (error, databaseRef) in
			completion(true)
		}
	}
	
	func GetUserInDatabase(withUid uId: String, completion: @escaping GetUserCompletionHandler ) {
		let ref = Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(uId)
		
		ref.observeSingleEvent(of: .value) { result in
			
			if result.exists() {
				let value = result.value as? NSDictionary
				
				let user = User(data: value as! [String : String])
				completion(true,user)
			}
		}
	}
}

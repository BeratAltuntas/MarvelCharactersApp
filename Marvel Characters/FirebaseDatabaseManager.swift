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
	
	func UpdateUserInDatabase(withUId UId: String, name: String, email: String, profileImage: String, birthdate: String, city: String, gender: String, password: String, completion: @escaping Databasecompletion) {
		let dict: [String: Any] = [
			"uid": UId,
			"email": email,
			"profileImageLink": profileImage,
			"namesurname":name,
			"birthdate":birthdate,
			"city":city,
			"gender": gender,
			"password": password
		]
		
		Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(UId).updateChildValues(dict) { (error, databaseRef) in
			completion(true)
		}
	}
	
	func CreateUserInDatabase(uId: String, name: String, email: String, password: String, completion: @escaping Databasecompletion) {
		let dict: [String: String] = [
			"uid": uId,
			"email": email,
			"profileImageLink": "",
			"namesurname":name,
			"birthdate":"",
			"city":"",
			"gender":"",
			"password": password
		]
		
		Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(uId).updateChildValues(dict) { (error, databaseRef) in
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

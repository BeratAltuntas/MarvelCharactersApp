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
typealias CompletionGetComicAndCharIds = (_ success: Bool, _ ids: [Int])-> Void
typealias CompletionGetComics = (_ success: Bool, _ result: ComicModelResult)-> Void
typealias CompletionGetCharacters = (_ success: Bool, _ result: CharacterModelResult)-> Void


final class FireBaseDatabaseManager {
	static let shared = FireBaseDatabaseManager()
	
	// MARK: - Users
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
	
	// MARK: - Comics
	func GetComic(withIds id: Int, completion: @escaping CompletionGetComics) {
		if FirebaseAuthManager.shared.IsUserSignedIn() {
			NetworkManager.shared.fetchData(endPoint: Config.comicMainUrl + "/" + String(id) + "?", type: ComicModel?.self) { result in
				switch result {
				case .success(let response):
					completion(true,response.data!.results!.first!)
				case .failure(let error):
					print(error)
					break
				}
			}
		}
	}
	func GetUsersLikedComics(userUid: String, completion: @escaping CompletionGetComicAndCharIds) {
		if FirebaseAuthManager.shared.IsUserSignedIn() {
			let ref = Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(userUid)
			ref.observeSingleEvent(of: .value) { result in
				let value = result.value as? NSDictionary
				let data = value?["comicsIds"] as? [Int]
				if data != nil {
					guard let ids = data else { return completion(false,[]) }
					completion(true, ids)
				} else {
					completion(false,[-1])
				}
			}
			
		}
	}
	func SetUserComics(user: User, completion: @escaping Databasecompletion) {
		guard let uid = user.uid else { return }
		Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(uid).updateChildValues(user.userComicDictionary) { (error, databaseRef) in
			completion(true)
		}
	}
	func DeleteUserLikedComic(deletingId: Int, completion: @escaping Databasecompletion) {
		if FirebaseAuthManager.shared.IsUserSignedIn(){
			guard let userUid = FirebaseAuthManager.shared.GetUserUid() else { return }
			GetUsersLikedComics(userUid: userUid) { success, ids in
				if success {
					var arraysOfIds = ids
					for (index,id) in ids.enumerated() {
						if id == deletingId {
							arraysOfIds.remove(at: index)
						}
					}
					let user = User(uId: userUid, comicResult: arraysOfIds, characterResult: [])
					Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(userUid).updateChildValues(user.userComicDictionary) { (error, databaseRef) in
					}
				}
			}
		}
	}
	
	// MARK: - Characters
	func GetCharacter(withIds id: Int, completion: @escaping CompletionGetCharacters) {
		if FirebaseAuthManager.shared.IsUserSignedIn() {
			NetworkManager.shared.fetchData(endPoint: Config.characterMainUrl + "/" + String(id) + "?", type: CharacterModel?.self) { result in
				switch result {
				case .success(let response):
					completion(true, response.data!.results!.first!)
				case .failure(let error):
					print(error)
					break
				}
			}
		}
	}
	func GetUsersLikedCharacters(userUid: String, completion: @escaping CompletionGetComicAndCharIds) {
		if FirebaseAuthManager.shared.IsUserSignedIn() {
			let ref = Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(userUid)
			
			ref.observeSingleEvent(of: .value) { result in
				let value = result.value as? NSDictionary
				let data = value?["charactersIds"] as? [Int]
				if data != nil {
					guard let ids = data else { return completion(false,[]) }
					completion(true, ids)
				} else {
					completion(false,[-1])
				}
			}
		}
	}
	func SetUsersLikedCharacters(user: User, completion: @escaping Databasecompletion) {
		guard let uid = user.uid else { return }
		Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(uid).updateChildValues(user.userCharacterDictionary) { (error, databaseRef) in
			completion(true)
		}
	}
	func DeleteUsersLikedCharacter(withCharId: Int, completion: @escaping Databasecompletion) {
		if FirebaseAuthManager.shared.IsUserSignedIn() {
			guard let userUid = FirebaseAuthManager.shared.GetUserUid() else { return }
			GetUsersLikedCharacters(userUid: userUid) { success, ids in
				if success {
					var arrayOfIds = ids
					for (index,id) in ids.enumerated() {
						if id == withCharId {
							arrayOfIds.remove(at: index)
						}
					}
					let tempUser = User(uId: userUid, comicResult: [], characterResult: arrayOfIds)
					Database.database(url: Config.firebaseDatabaseRefrenceUrl).reference().child(Config.firebaseDatabaseReferenceMainChild).child(tempUser.uid!).updateChildValues(tempUser.userCharacterDictionary) { (error, databaseRef) in
						if error == nil {
							completion(true)
						}
					}
				}
			}
		}
	}
}

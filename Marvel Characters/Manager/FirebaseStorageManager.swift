//
//  FirebaseStorageManager.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 15.05.2022.
//
import FirebaseStorage
import Foundation

typealias CompletionStorage = (_ complete: Bool, _ imageStringPath: String)-> Void

final class FirebaseStorageManager {
	static let shared = FirebaseStorageManager()
	
	func UploadImageToFirebaseStorage(uId: String, imageData: Data, completion: @escaping CompletionStorage) {
		
		let storageRef = Storage.storage().reference(forURL: Config.firebaseStorageReferenceUrl)
		let profileRef = storageRef.child(Config.firebaseStorageReferenceMainChild).child(uId)
		
		let metaData = StorageMetadata()
		metaData.contentType = "image/jpg"
		
		profileRef.putData(imageData, metadata: metaData) { (storageMetaData, error) in
			if error != nil {
				print(error!.localizedDescription)
				return
			}
			profileRef.downloadURL { (url, error) in
				if let metaImageUrl = url?.absoluteString {
					completion(true, metaImageUrl)
				}
			}
		}
	}
}

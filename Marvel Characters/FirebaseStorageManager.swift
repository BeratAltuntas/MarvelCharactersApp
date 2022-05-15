//
//  FirebaseStorageManager.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 15.05.2022.
//
import FirebaseStorage
import Foundation

final class FirebaseStorageManager {
	static let shared = FirebaseStorageManager()
	
	func UploadImageToFirebaseStorage(uId: String, image: UIImage) {
		guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
		
		let storageRef = Storage.storage().reference(forURL: Config.firebaseStorageReferenceUrl)
		let profileRef = storageRef.child(Config.firebaseStorageReferenceMainChild).child(uId)
		
		let metaData = StorageMetadata()
		metaData.contentType = "image/jpg"
		
		profileRef.putData(imageData, metadata: metaData) { (storageMetaData, error) in
			if error != nil {
				print(error!.localizedDescription)
				return
			}
		}
	}
}

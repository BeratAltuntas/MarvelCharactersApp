//
//  User.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 15.05.2022.
//

import Foundation

class User: Codable {
	var uid: String?
	var email: String?
	var profileImageLink: String?
	var namesurname: String?
	var birthdate: String?
	var city: String?
	var gender: String?
	var dictionary: [String: String] {
		return ["uid": uid!,
				"email": email!,
				"profileImageLink": profileImageLink!,
				"namesurname":namesurname!,
				"birthdate":birthdate!,
				"city":city!,
				"gender":gender!]
	}
	
	init(data: [String: String]) {
		self.uid = data["uid"]
		self.email = data["email"]
		self.profileImageLink = data["profileImageLink"]
		self.namesurname = data["namesurname"]
		self.birthdate = data["birthdate"]
		self.city = data["city"]
		self.gender = data["gender"]
	}
	
	init(uId: String?, email: String?, profileImageLink: String?, namesurname: String?, birthdate: String?, city: String?, gender: String?) {
		self.uid = uId
		self.email = email
		self.profileImageLink = profileImageLink
		self.namesurname = namesurname
		self.birthdate = birthdate
		self.city = city
		self.gender = gender
	}
}

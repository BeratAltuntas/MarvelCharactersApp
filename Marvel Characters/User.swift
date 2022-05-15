//
//  User.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 15.05.2022.
//

import Foundation

class User {
	let uid: String?
	let email: String?
	let profileImageLink: String?
	let namesurname: String?
	let birthdate: String?
	let city: String?
	let gender: String?
	
	init(data: [String: String]) {
		self.uid = data["uid"]
		self.email = data["email"]
		self.profileImageLink = data["profileImageLink"]
		self.namesurname = data["namesurname"]
		self.birthdate = data["birthdate"]
		self.city = data["city"]
		self.gender = data["gender"]
	}
}

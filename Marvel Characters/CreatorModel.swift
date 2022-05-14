//
//  CreatorModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 14.05.2022.

import Foundation

// MARK: - CreatorModel
struct CreatorModel: Codable {
	let code: Int?
	let status, copyright, attributionText, attributionHTML: String?
	let etag: String?
	let data: CreatorModelDataClass?
}

// MARK: - CreatorModelDataClass
struct CreatorModelDataClass: Codable {
	let offset, limit, total, count: Int?
	let results: [CreatorModelResult]?
}

// MARK: - CreatorModelResult
struct CreatorModelResult: Codable {
	let id: Int?
	let firstName, middleName, lastName, suffix: String?
	let fullName: String?
	let modified: String?
	let thumbnail: CreatorModelThumbnail?
	let resourceURI: String?
	let comics, series: CreatorModelComics?
	let stories: CreatorModelStories?
	let events: CreatorModelComics?
	let urls: [CreatorModelURLElement]?
}

// MARK: - CreatorModelComics
struct CreatorModelComics: Codable {
	let available: Int?
	let collectionURI: String?
	let items: [CreatorModelComicsItem]?
	let returned: Int?
}

// MARK: - CreatorModelComicsItem
struct CreatorModelComicsItem: Codable {
	let resourceURI: String?
	let name: String?
}

// MARK: - CreatorModelStories
struct CreatorModelStories: Codable {
	let available: Int?
	let collectionURI: String?
	let items: [CreatorModelStoriesItem]?
	let returned: Int?
}

// MARK: - CreatorModelStoriesItem
struct CreatorModelStoriesItem: Codable {
	let resourceURI: String?
	let name: String?
	let type: String?
}

// MARK: - CreatorModelThumbnail
struct CreatorModelThumbnail: Codable {
	let path: String?
	let thumbnailExtension: String?
}

// MARK: - CreatorModelURLElement
struct CreatorModelURLElement: Codable {
	let type: String?
	let url: String?
}

    // This file was generated from JSON Schema using quicktype, do not modify it directly.
    // To parse the JSON, add this file to your project and do:
    //
    //   let characterModel = try? newJSONDecoder().decode(CharacterModel.self, from: jsonData)

import Foundation

    // MARK: - CharacterModel
struct CharacterModel: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: CharacterModelDataClass?
}

    // MARK: - DataClass
struct CharacterModelDataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [CharacterModelResult]?
}

    // MARK: - Result
struct CharacterModelResult: Codable {
    let id: Int?
    let name, resultDescription: String?
    let modified: String?
    let thumbnail: CharacterModelThumbnail?
    let resourceURI: String?
    let comics, series: CharacterModelComics?
    let stories: CharacterModelStories?
    let events: CharacterModelComics?
    let urls: [CharacterModelURLElement]?
}

    // MARK: - Characters
struct CharacterModelComics: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CharacterModelSeriesItem]?
    let returned: Int?
}

    // MARK: - CharactersItem
struct CharacterModelSeriesItem: Codable {
    let resourceURI: String?
    let name: String?
}

    // MARK: - Stories
struct CharacterModelStories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CharacterModelStoriesItem]?
    let returned: Int?
}

    // MARK: - StoriesItem
struct CharacterModelStoriesItem: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

    // MARK: - Thumbnail
struct CharacterModelThumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?
}
    // MARK: - URLElement
struct CharacterModelURLElement: Codable {
    let type: String?
    let url: String?
}

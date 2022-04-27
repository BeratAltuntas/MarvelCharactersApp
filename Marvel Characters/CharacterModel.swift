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
    let modified: Date?
    let thumbnail: CharacterModelThumbnail?
    let resourceURI: String?
    let comics, series: CharacterModelComics?
    let stories: CharacterModelStories?
    let events: CharacterModelComics?
    let urls: [CharacterModelURLElement]?
    
    enum CharacterModelCodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

    // MARK: - Comics
struct CharacterModelComics: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CharacterModelComicsItem]?
    let returned: Int?
}

    // MARK: - ComicsItem
struct CharacterModelComicsItem: Codable {
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
    let type: CharacterModelItemType?
}

enum CharacterModelItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
}

    // MARK: - Thumbnail
struct CharacterModelThumbnail: Codable {
    let path: String?
    let thumbnailExtension: CharacterModelExtension?
    
    enum CharacterModelCodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum CharacterModelExtension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

    // MARK: - URLElement
struct CharacterModelURLElement: Codable {
    let type: CharacterModelURLType?
    let url: String?
}

enum CharacterModelURLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

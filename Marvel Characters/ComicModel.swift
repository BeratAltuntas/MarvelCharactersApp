import Foundation

// MARK: - ComicModel
struct ComicModel: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let id, digitalID: Int?
    let title: String?
    let issueNumber: Int?
    let variantDescription, resultDescription: String?
    let modified: String?
    let isbn, upc, diamondCode, ean: String?
    let issn, format: String?
    let pageCount: Int?
    let resourceURI: String?
    let urls: [URLElement]?
    let series: Series?
    let variants: [Series]?
    let dates: [DateElement]?
    let prices: [Price]?
    let thumbnail: Thumbnail?
    let images: [Images]?
    let creators, characters, stories, events: Characters?
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Item]?
    let returned: Int?
}

// MARK: - Item
struct Item: Codable {
    let resourceURI: String?
    let name, role, type: String?
}

// MARK: - DateElement
struct DateElement: Codable {
    let type: String?
    let date: String?
}

// MARK: - Price
struct Price: Codable {
    let type: String?
    let price: Double?
}

// MARK: - Series
struct Series: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?
}

struct Images: Codable {
    let path: String?
    let imagesExtension: String?
}
// MARK: - URLElement
struct URLElement: Codable {
    let type: String?
    let url: String?
}

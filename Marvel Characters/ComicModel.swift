import Foundation

// MARK: - ComicModel
struct ComicModel: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: ComicModelData?
}

// MARK: - DataClass
struct ComicModelData: Codable {
    let offset, limit, total, count: Int?
    let results: [ComicModelResult]?
}

// MARK: - Result
struct ComicModelResult: Codable {
    let id, digitalID: Int?
    let title: String?
    let issueNumber: Int?
    let variantDescription, resultDescription: String?
    let modified: String?
    let isbn, upc, diamondCode, ean: String?
    let issn, format: String?
    let pageCount: Int?
    let textObjects: [ComicModelTextObject]
    let resourceURI: String?
    let urls: [ComicModelURLElement]?
    let series: ComicModelSeries?
    let variants: [ComicModelSeries]?
    let dates: [ComicModelDateElement]?
    let prices: [ComicModelPrice]?
    let thumbnail: ComicModelThumbnail?
    let images: [ComicModelImages]?
    let creators, characters, stories, events: ComicModelCharacters?
    
}
// MARK: - TextObject
struct ComicModelTextObject: Codable {
    let type: String?
    let language: String?
    let text: String?
}

// MARK: - Characters
struct ComicModelCharacters: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicModelItem]?
    let returned: Int?
}

// MARK: - Item
struct ComicModelItem: Codable {
    let resourceURI: String?
    let name, role, type: String?
}

// MARK: - DateElement
struct ComicModelDateElement: Codable {
    let type: String?
    let date: String?
}

// MARK: - Price
struct ComicModelPrice: Codable {
    let type: String?
    let price: Double?
}

// MARK: - Series
struct ComicModelSeries: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Thumbnail
struct ComicModelThumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?
}

struct ComicModelImages: Codable {
    let path: String?
    let imagesExtension: String?
}
// MARK: - URLElement
struct ComicModelURLElement: Codable {
    let type: String?
    let url: String?
}

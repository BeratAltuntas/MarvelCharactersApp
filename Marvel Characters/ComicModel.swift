    // This file was generated from JSON Schema using quicktype, do not modify it directly.
    // To parse the JSON, add this file to your project and do:
    //
    //   let comicModel = try? newJSONDecoder().decode(ComicModel.self, from: jsonData)

import Foundation

    // MARK: - ComicModel
struct ComicModel: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: ComicModelDataClass?
}

    // MARK: - DataClass
struct ComicModelDataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [ComicModelResult]?
}

    // MARK: - Result
struct ComicModelResult: Codable {
    let id, digitalID: Int?
    let title: String?
    let issueNumber: Int?
    let variantDescription, resultDescription: String?
    let modified: ComicModelModifiedUnion?
    let isbn, upc: String?
    let diamondCode: ComicModelDiamondCode?
    let ean, issn: String?
    let format: ComicModelFormat?
    let pageCount: Int?
    let textObjects: [ComicModelTextObject]?
    let resourceURI: String?
    let urls: [ComicModelURLElement]?
    let series: ComicModelSeries?
    let variants: [ComicModelSeries]?
    let collections: [ComicModelJSONAny]?
    let collectedIssues: [ComicModelSeries]?
    let dates: [ComicModelDateElement]?
    let prices: [ComicModelPrice]?
    let thumbnail: ComicModelThumbnail?
    let images: [ComicModelThumbnail]?
    let creators: ComicModelCreators?
    let characters: ComicModelCharacters?
    let stories: ComicModelStories?
    let events: ComicModelCharacters?
    
    enum ComicModelCodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, issueNumber, variantDescription
        case resultDescription = "description"
        case modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collections, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events
    }
}

    // MARK: - Characters
struct ComicModelCharacters: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicModelSeries]?
    let returned: Int?
}

    // MARK: - Series
struct ComicModelSeries: Codable {
    let resourceURI: String?
    let name: String?
}

    // MARK: - Creators
struct ComicModelCreators: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicModelCreatorsItem]?
    let returned: Int?
}

    // MARK: - CreatorsItem
struct ComicModelCreatorsItem: Codable {
    let resourceURI: String?
    let name: String?
    let role: ComicModelRole?
}

enum ComicModelRole: String, Codable {
    case colorist = "colorist"
    case editor = "editor"
    case inker = "inker"
    case letterer = "letterer"
    case penciler = "penciler"
    case penciller = "penciller"
    case pencillerCover = "penciller (cover)"
    case writer = "writer"
}

    // MARK: - DateElement
struct ComicModelDateElement: Codable {
    let type: ComicModelDateType?
    let date: ComicModelModifiedUnion?
}

enum ComicModelModifiedUnion: Codable {
    case dateTime(Date)
    case enumeration(ComicModelModifiedEnum)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Date.self) {
            self = .dateTime(x)
            return
        }
        if let x = try? container.decode(ComicModelModifiedEnum.self) {
            self = .enumeration(x)
            return
        }
        throw DecodingError.typeMismatch(ComicModelModifiedUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ModifiedUnion"))
    }
    
    func ComicModelencode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dateTime(let x):
            try container.encode(x)
        case .enumeration(let x):
            try container.encode(x)
        }
    }
}

enum ComicModelModifiedEnum: String, Codable {
    case the00011130T0000000500 = "-0001-11-30T00:00:00-0500"
}

enum ComicModelDateType: String, Codable {
    case focDate = "focDate"
    case onsaleDate = "onsaleDate"
}

enum ComicModelDiamondCode: String, Codable {
    case empty = ""
    case jul190068 = "JUL190068"
}

enum ComicModelFormat: String, Codable {
    case comic = "Comic"
    case digest = "Digest"
    case empty = ""
    case tradePaperback = "Trade Paperback"
}

    // MARK: - Thumbnail
struct ComicModelThumbnail: Codable {
    let path: String?
    let thumbnailExtension: ComicModelExtension?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum ComicModelExtension: String, Codable {
    case jpg = "jpg"
}

    // MARK: - Price
struct ComicModelPrice: Codable {
    let type: ComicModelPriceType?
    let price: Double?
}

enum ComicModelPriceType: String, Codable {
    case printPrice = "printPrice"
}

    // MARK: - Stories
struct ComicModelStories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicModelStoriesItem]?
    let returned: Int?
}

    // MARK: - StoriesItem
struct ComicModelStoriesItem: Codable {
    let resourceURI: String?
    let name: String?
    let type: ComicModelItemType?
}

enum ComicModelItemType: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
    case promo = "promo"
}

    // MARK: - TextObject
struct ComicModelTextObject: Codable {
    let type: ComicModelTextObjectType?
    let language: ComicModelLanguage?
    let text: String?
}

enum ComicModelLanguage: String, Codable {
    case enUs = "en-us"
}

enum ComicModelTextObjectType: String, Codable {
    case issueSolicitText = "issue_solicit_text"
}

    // MARK: - URLElement
struct ComicModelURLElement: Codable {
    let type: ComicModelURLType?
    let url: String?
}

enum ComicModelURLType: String, Codable {
    case detail = "detail"
    case purchase = "purchase"
}

    // MARK: - Encode/decode helpers

class ComicModelJSONNull: Codable, Hashable {
    
    public static func == (lhs: ComicModelJSONNull, rhs: ComicModelJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(ComicModelJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class ComicModelJSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class ComicModelJSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(ComicModelJSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return ComicModelJSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func ComicModeldecode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return ComicModelJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try ComicModeldecodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: ComicModelJSONCodingKey.self) {
            return try ComicModeldecodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func ComicModeldecode(from container: inout KeyedDecodingContainer<ComicModelJSONCodingKey>, forKey key: ComicModelJSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return ComicModelJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try ComicModeldecodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: ComicModelJSONCodingKey.self, forKey: key) {
            return try ComicModeldecodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func ComicModeldecodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try ComicModeldecode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func ComicModeldecodeDictionary(from container: inout KeyedDecodingContainer<ComicModelJSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try ComicModeldecode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func ComicModelencode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is ComicModelJSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try ComicModelencode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: ComicModelJSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<ComicModelJSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = ComicModelJSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is ComicModelJSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try ComicModelencode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: ComicModelJSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is ComicModelJSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try ComicModelJSONAny.ComicModeldecodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: ComicModelJSONCodingKey.self) {
            self.value = try ComicModelJSONAny.ComicModeldecodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try ComicModelJSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try ComicModelJSONAny.ComicModelencode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: ComicModelJSONCodingKey.self)
            try ComicModelJSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try ComicModelJSONAny.encode(to: &container, value: self.value)
        }
    }
}

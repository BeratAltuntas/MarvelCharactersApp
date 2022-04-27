//
//  ComicModel.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import Foundation
    // This file was generated from JSON Schema using quicktype, do not modify it directly.
    // To parse the JSON, add this file to your project and do:
    //
    //   let comic = try? newJSONDecoder().decode(Comic.self, from: jsonData)

    import Foundation

    // MARK: - Comic
    class Comic: Codable {
        let code: Int
        let status, copyright, attributionText, attributionHTML: String
        let etag: String
        let data: DataClass

        init(code: Int, status: String, copyright: String, attributionText: String, attributionHTML: String, etag: String, data: DataClass) {
            self.code = code
            self.status = status
            self.copyright = copyright
            self.attributionText = attributionText
            self.attributionHTML = attributionHTML
            self.etag = etag
            self.data = data
        }
    }

    // MARK: - DataClass
    class DataClass: Codable {
        let offset, limit, total, count: Int
        let results: [Result]

        init(offset: Int, limit: Int, total: Int, count: Int, results: [Result]) {
            self.offset = offset
            self.limit = limit
            self.total = total
            self.count = count
            self.results = results
        }
    }

    // MARK: - Result
    class Result: Codable {
        let id, digitalID: Int
        let title: String
        let issueNumber: Int
        let variantDescription, resultDescription: String
        let modified: ModifiedUnion
        let isbn, upc: String
        let diamondCode: DiamondCode
        let ean, issn: String
        let format: Format
        let pageCount: Int
        let textObjects: [TextObject]
        let resourceURI: String
        let urls: [URLElement]
        let series: Series
        let variants: [Series]
        let collections: [JSONAny]
        let collectedIssues: [Series]
        let dates: [DateElement]
        let prices: [Price]
        let thumbnail: Thumbnail
        let images: [Thumbnail]
        let creators: Creators
        let characters: Characters
        let stories: Stories
        let events: Characters

        enum CodingKeys: String, CodingKey {
            case id
            case digitalID = "digitalId"
            case title, issueNumber, variantDescription
            case resultDescription = "description"
            case modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collections, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events
        }

        init(id: Int, digitalID: Int, title: String, issueNumber: Int, variantDescription: String, resultDescription: String, modified: ModifiedUnion, isbn: String, upc: String, diamondCode: DiamondCode, ean: String, issn: String, format: Format, pageCount: Int, textObjects: [TextObject], resourceURI: String, urls: [URLElement], series: Series, variants: [Series], collections: [JSONAny], collectedIssues: [Series], dates: [DateElement], prices: [Price], thumbnail: Thumbnail, images: [Thumbnail], creators: Creators, characters: Characters, stories: Stories, events: Characters) {
            self.id = id
            self.digitalID = digitalID
            self.title = title
            self.issueNumber = issueNumber
            self.variantDescription = variantDescription
            self.resultDescription = resultDescription
            self.modified = modified
            self.isbn = isbn
            self.upc = upc
            self.diamondCode = diamondCode
            self.ean = ean
            self.issn = issn
            self.format = format
            self.pageCount = pageCount
            self.textObjects = textObjects
            self.resourceURI = resourceURI
            self.urls = urls
            self.series = series
            self.variants = variants
            self.collections = collections
            self.collectedIssues = collectedIssues
            self.dates = dates
            self.prices = prices
            self.thumbnail = thumbnail
            self.images = images
            self.creators = creators
            self.characters = characters
            self.stories = stories
            self.events = events
        }
    }

    // MARK: - Characters
    class Characters: Codable {
        let available: Int
        let collectionURI: String
        let items: [Series]
        let returned: Int

        init(available: Int, collectionURI: String, items: [Series], returned: Int) {
            self.available = available
            self.collectionURI = collectionURI
            self.items = items
            self.returned = returned
        }
    }

    // MARK: - Series
    class Series: Codable {
        let resourceURI: String
        let name: String

        init(resourceURI: String, name: String) {
            self.resourceURI = resourceURI
            self.name = name
        }
    }

    // MARK: - Creators
    class Creators: Codable {
        let available: Int
        let collectionURI: String
        let items: [CreatorsItem]
        let returned: Int

        init(available: Int, collectionURI: String, items: [CreatorsItem], returned: Int) {
            self.available = available
            self.collectionURI = collectionURI
            self.items = items
            self.returned = returned
        }
    }

    // MARK: - CreatorsItem
    class CreatorsItem: Codable {
        let resourceURI: String
        let name: String
        let role: Role

        init(resourceURI: String, name: String, role: Role) {
            self.resourceURI = resourceURI
            self.name = name
            self.role = role
        }
    }

    enum Role: String, Codable {
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
    class DateElement: Codable {
        let type: DateType
        let date: ModifiedUnion

        init(type: DateType, date: ModifiedUnion) {
            self.type = type
            self.date = date
        }
    }

    enum ModifiedUnion: Codable {
        case dateTime(Date)
        case enumeration(ModifiedEnum)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Date.self) {
                self = .dateTime(x)
                return
            }
            if let x = try? container.decode(ModifiedEnum.self) {
                self = .enumeration(x)
                return
            }
            throw DecodingError.typeMismatch(ModifiedUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ModifiedUnion"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .dateTime(let x):
                try container.encode(x)
            case .enumeration(let x):
                try container.encode(x)
            }
        }
    }

    enum ModifiedEnum: String, Codable {
        case the00011130T0000000500 = "-0001-11-30T00:00:00-0500"
    }

    enum DateType: String, Codable {
        case focDate = "focDate"
        case onsaleDate = "onsaleDate"
    }

    enum DiamondCode: String, Codable {
        case empty = ""
        case jul190068 = "JUL190068"
    }

    enum Format: String, Codable {
        case comic = "Comic"
        case digest = "Digest"
        case empty = ""
        case tradePaperback = "Trade Paperback"
    }

    // MARK: - Thumbnail
    class Thumbnail: Codable {
        let path: String
        let thumbnailExtension: Extension

        enum CodingKeys: String, CodingKey {
            case path
            case thumbnailExtension = "extension"
        }

        init(path: String, thumbnailExtension: Extension) {
            self.path = path
            self.thumbnailExtension = thumbnailExtension
        }
    }

    enum Extension: String, Codable {
        case jpg = "jpg"
    }

    // MARK: - Price
    class Price: Codable {
        let type: PriceType
        let price: Double

        init(type: PriceType, price: Double) {
            self.type = type
            self.price = price
        }
    }

    enum PriceType: String, Codable {
        case printPrice = "printPrice"
    }

    // MARK: - Stories
    class Stories: Codable {
        let available: Int
        let collectionURI: String
        let items: [StoriesItem]
        let returned: Int

        init(available: Int, collectionURI: String, items: [StoriesItem], returned: Int) {
            self.available = available
            self.collectionURI = collectionURI
            self.items = items
            self.returned = returned
        }
    }

    // MARK: - StoriesItem
    class StoriesItem: Codable {
        let resourceURI: String
        let name: String
        let type: ItemType

        init(resourceURI: String, name: String, type: ItemType) {
            self.resourceURI = resourceURI
            self.name = name
            self.type = type
        }
    }

    enum ItemType: String, Codable {
        case cover = "cover"
        case interiorStory = "interiorStory"
        case promo = "promo"
    }

    // MARK: - TextObject
    class TextObject: Codable {
        let type: TextObjectType
        let language: Language
        let text: String

        init(type: TextObjectType, language: Language, text: String) {
            self.type = type
            self.language = language
            self.text = text
        }
    }

    enum Language: String, Codable {
        case enUs = "en-us"
    }

    enum TextObjectType: String, Codable {
        case issueSolicitText = "issue_solicit_text"
    }

    // MARK: - URLElement
    class URLElement: Codable {
        let type: URLType
        let url: String

        init(type: URLType, url: String) {
            self.type = type
            self.url = url
        }
    }

    enum URLType: String, Codable {
        case detail = "detail"
        case purchase = "purchase"
    }

    // MARK: - Encode/decode helpers

    class JSONNull: Codable, Hashable {

        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
        }

        public var hashValue: Int {
            return 0
        }

        public init() {}

        public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }

    class JSONCodingKey: CodingKey {
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

    class JSONAny: Codable {

        let value: Any

        static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
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
                return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
        }

        static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
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
                    return JSONNull()
                }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
        }

        static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
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
                    return JSONNull()
                }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
        }

        static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                let value = try decode(from: &container)
                arr.append(value)
            }
            return arr
        }

        static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                let value = try decode(from: &container, forKey: key)
                dict[key.stringValue] = value
            }
            return dict
        }

        static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                if let value = value as? Bool {
                    try container.encode(value)
                } else if let value = value as? Int64 {
                    try container.encode(value)
                } else if let value = value as? Double {
                    try container.encode(value)
                } else if let value = value as? String {
                    try container.encode(value)
                } else if value is JSONNull {
                    try container.encodeNil()
                } else if let value = value as? [Any] {
                    var container = container.nestedUnkeyedContainer()
                    try encode(to: &container, array: value)
                } else if let value = value as? [String: Any] {
                    var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                    try encode(to: &container, dictionary: value)
                } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
                }
            }
        }

        static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                let key = JSONCodingKey(stringValue: key)!
                if let value = value as? Bool {
                    try container.encode(value, forKey: key)
                } else if let value = value as? Int64 {
                    try container.encode(value, forKey: key)
                } else if let value = value as? Double {
                    try container.encode(value, forKey: key)
                } else if let value = value as? String {
                    try container.encode(value, forKey: key)
                } else if value is JSONNull {
                    try container.encodeNil(forKey: key)
                } else if let value = value as? [Any] {
                    var container = container.nestedUnkeyedContainer(forKey: key)
                    try encode(to: &container, array: value)
                } else if let value = value as? [String: Any] {
                    var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
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
            } else if value is JSONNull {
                try container.encodeNil()
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }

        public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                let container = try decoder.singleValueContainer()
                self.value = try JSONAny.decode(from: container)
            }
        }

        public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                var container = encoder.unkeyedContainer()
                try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                var container = encoder.container(keyedBy: JSONCodingKey.self)
                try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                var container = encoder.singleValueContainer()
                try JSONAny.encode(to: &container, value: self.value)
            }
        }
    }

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: String
    let lat, lon: Double
    let name: String
    let type: TypeElement?
    let routeNumber, color, routeName, subwayID: String?
    let shareURL: String
    let wifi, usb: Bool
    let transportType: JSONNull?
    let transportTypes: [TypeElement]
    let isFavorite: Bool
    let icon: JSONNull?
    let mapIcon: String?
    let mapIconSmall: JSONNull?
    let cityShuttle, electrobus: Bool

    enum CodingKeys: String, CodingKey {
        case id, lat, lon, name, type, routeNumber, color, routeName
        case subwayID = "subwayId"
        case shareURL = "shareUrl"
        case wifi, usb, transportType, transportTypes, isFavorite, icon, mapIcon, mapIconSmall, cityShuttle, electrobus
    }
}

enum TypeElement: String, Codable {
    case bus = "bus"
    case mcd = "mcd"
    case publicTransport = "public_transport"
    case subwayHall = "subwayHall"
    case train = "train"
    case tram = "tram"
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

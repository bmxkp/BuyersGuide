//
//  Model.swift
//  BuyersGuide
//
//  Created by Kanjanaporn on 27/8/2562 BE.
//  Copyright © 2562 SCBiOS. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Phone {
    let id : Int
    let name: String
    let price: Float
    let thumbImageURL: String
    let rating: Float
    let description: String
}

extension Phone {
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        price = json["price"].floatValue
        rating = json["rating"].floatValue
        description = json["description"].stringValue
        thumbImageURL = json["thumbImageURL"].stringValue
    }
}


typealias Model = [Images]

struct Images: Codable {
    let url: String
    let id, mobileID: Int

    enum CodingKeys: String, CodingKey {
        case url, id
        case mobileID = "mobile_id"
    }
}

// MARK: Convenience initializers

extension Images {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Images.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Array where Element == Model.Element {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Model.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}


// MARK: Convenience initializers


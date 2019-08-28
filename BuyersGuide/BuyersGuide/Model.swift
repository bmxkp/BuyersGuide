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

struct Images {
    let url: String

    enum CodingKeys: String, CodingKey {
        case url, id
        case mobileID = "mobile_id"
    }
}


// MARK: Convenience initializers


//
//  Item.swift
//  SlackApp
//
//  Created by Claus Höfele on 21.08.16.
//
//

import Foundation
import MongoKitten

struct Item {
    var id: String
    var name: String
}

extension Item: MongoConvertible {
    init(document: Document) {
        self.id = document["_id"].objectIdValue!.hexString
        self.name = document["name"].stringValue ?? ""
    }
}

extension Item: DictionaryConvertible {
    init(dictionary: [String : AnyType]) {
        self.id = dictionary["id"] as! String
        self.name = dictionary["name"] as? String ?? ""
    }

    var dictionary: [String : AnyType] {
        return ["id": id, "name": name]
    }
}

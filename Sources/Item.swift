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
    var dictionary: [String : AnyObject] {
        return ["id": id, "name": name]
    }
}

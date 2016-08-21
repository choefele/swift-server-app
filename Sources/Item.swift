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
    var name: String
}

extension Item: MongoConvertible {
    init(document: Document) {
        self.name = document["name"].stringValue ?? ""
    }
}

extension Item: DictionaryConvertible {
    var dictionary: [String : AnyObject] {
        return ["name": name]
    }
}

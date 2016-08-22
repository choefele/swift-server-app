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
    var name: String?
}

extension Item: DictionaryConvertible {
    init(dictionary: [String : AnyType]) {
        self.id = dictionary["id"] as! String
        self.name = dictionary["name"] as? String
    }

    var dictionary: [String : AnyType] {
        var dictionary = [String: AnyType]()
        dictionary["id"] = id
        dictionary["name"] = name
        return dictionary
    }
}

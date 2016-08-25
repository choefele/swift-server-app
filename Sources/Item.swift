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

struct ItemEndpoint {
    static func generateDocument(parameters: [String: String]) -> Document {
        return Document()
    }
    
    static func generateItem(document: Document) -> Item {
        let id = document["_id"].objectIdValue!.hexString
        let name = document["name"].stringValue
        
        return Item(id: id, name: name)
    }
    
    static func generateJsonDictionary(item: Item) -> [String: AnyType] {
        var dictionary = [String: AnyType]()
        
        dictionary["id"] = item.id
        dictionary["name"] = item.name

        return dictionary
    }
}

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
    
    static func generateJsonDictionary(document: Document) -> [String: AnyType] {
        var dictionary = [String: AnyType]()
        
        dictionary["id"] = document["_id"].objectIdValue!.hexString
        dictionary["name"] = document["name"].stringValue

        return dictionary
    }
}

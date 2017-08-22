//
//  Item.swift
//  SwiftServer
//
//  Created by Claus Höfele on 21.08.16.
//
//

import Foundation
import MongoKitten

public struct ItemEndpoint {
    public static func generateDocument(parameters: [String: String]) -> Document {
        return Document()
    }
    
    public static func generateJsonDictionary(document: Document) -> [String: Any] {
        var dictionary = [String: Any]()

        dictionary["id"] = ObjectId(document["_id"])?.hexString
        dictionary["name"] = String(document["name"])

        return dictionary
    }
}

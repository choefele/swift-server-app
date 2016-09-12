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
    
    public static func generateJsonDictionary(document: Document) -> [String: AnyType] {
        var dictionary = [String: AnyType]()
        
        dictionary["id"] = document["_id"].objectIdValue!.hexString
        dictionary["name"] = document["name"].stringValue

        return dictionary
    }
}

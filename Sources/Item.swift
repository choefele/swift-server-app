//
//  Item.swift
//  SlackApp
//
//  Created by Claus Höfele on 21.08.16.
//
//

import Foundation
import MongoKitten

struct Data {
    var id: String
    var name: String?
}

struct DataEndpoint {
    static func generateDocument(parameters: [String: String]) -> Document {
        return Document()
    }
    
    static func generateItem(document: Document) -> Data {
        return Data(id: "", name: "")
    }
    
    static func generateJsonDictionary(data: Data) -> [String: AnyType] {
        return ["test": "test"]
    }
}

struct Data2 {
    var id: String
    var name: String?
}

struct Data2Endpoint {
    static func generateDocument(parameters: [String: String]) -> Document {
        return Document()
    }
    
    static func generateItem(document: Document) -> Data2 {
        return Data2(id: "", name: "")
    }
    
    static func generateJsonDictionary(data: Data2) -> [String: AnyType] {
        return ["test": "test"]
    }
}

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

extension Item: CRUDMongoDatabaseConvertibleV2 {
    init(document: Document) {
        self.id = document["_id"].objectIdValue!.hexString
        self.name = document["name"].stringValue
    }
    
    var document: Document {
        var document = Document()
        
        if let name = name {
            document["name"] = .string(name)
        }
        
        return document
    }
}

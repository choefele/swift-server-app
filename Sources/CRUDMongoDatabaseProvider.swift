//
//  CRUDMongoDatabaseProvider.swift
//  SlackApp
//
//  Created by Claus Höfele on 22/08/16.
//
//

import Foundation
import MongoKitten

class CRUDMongoProviderV3 {
    let collection: MongoKitten.Collection
    
    init(collection: MongoKitten.Collection) {
        self.collection = collection
    }
    
    func createItem(document: Document) throws -> Document {
        let resultDocument = try collection.insert(document)
        return resultDocument
    }
    
    func readItems(query: QueryProtocol) throws -> [Document] {
        let documents = try collection.find(matching: query)
        return Array(documents)
    }
    
    func readItem(objectId: ObjectId) throws -> Document? {
        let document = try collection.findOne(matching: "_id" == objectId)
        return document
    }
    
    func deleteItem(objectId: ObjectId) throws -> Bool {
        guard let document = try collection.findOne(matching: "_id" == objectId) else {
            return false
        }
        try collection.remove(matching: document)
        return true
    }
}

protocol CRUDMongoDatabaseConvertibleV2 {
    init(document: Document)
    var document: Document {get}
}

class CRUDMongoDatabaseProviderV2<Item: CRUDMongoDatabaseConvertibleV2>: CRUDDatabaseProviderV2 {
    let collection: MongoKitten.Collection
    
    init(collection: MongoKitten.Collection) {
        self.collection = collection
    }
    
    func readItems() throws -> [Item] {
        let documents = try collection.find()
        let items = documents.map(Item.init)
        return items
    }
    
    func createItem(_ item: Item) throws -> Item {
        let document = item.document
        let resultDocument = try collection.insert(document)
        let resultItem = Item(document: resultDocument)
        
        return resultItem
    }
    
    func readItem(id: String) throws -> Item? {
        guard let objectID = try? ObjectId(id),
            let document = try collection.findOne(matching: "_id" == objectID) else {
                return nil
        }
        
        let item = Item(document: document)
        return item
    }
}

class CRUDMongoDatabaseProvider: CRUDDatabaseProvider {
    let collection: MongoKitten.Collection

    init(collection: MongoKitten.Collection) {
        self.collection = collection
    }

    private static func convertFromDocument(document: Document) -> [String: AnyType] {
        var dictionary = [String: AnyType]()
        
        for element in document {
            switch element.value {
            case .double(let doubleValue):
                dictionary[element.key] = doubleValue
            case .string(let stringValue):
                dictionary[element.key] = stringValue
            case .objectId(let objectId):
                dictionary["id"] = objectId.hexString
            case .boolean(let boolValue):
                dictionary[element.key] = boolValue
            case .dateTime(let dateValue):
                dictionary[element.key] = dateValue
            case .int32(let int32Value):
                dictionary[element.key] = Int(int32Value)
            case .int64(let int64Value):
                dictionary[element.key] = Int(int64Value)
            default:
                break
            }
        }

        return dictionary
    }
    private static func convertToDocument(dictionary: [String: AnyType]) -> Document {
        var document = Document()
        
        for element in dictionary {
            switch element.value {
            case let doubleValue as Double:
                document[element.key] = .double(doubleValue)
            case let stringValue as String:
                document[element.key] = .string(stringValue)
            case let boolValue as Bool:
                document[element.key] = .boolean(boolValue)
            case let dateValue as Date:
                document[element.key] = .dateTime(dateValue)
            case let intValue as Int:
                document[element.key] = .int64(Int64(intValue))
            default:
                break
            }            
        }
        
        return document
    }

    func readItems() throws -> [[String: AnyType]] {
        let documents = try collection.find()
        let items = documents.map(CRUDMongoDatabaseProvider.convertFromDocument)
        return items
    }

    func createItem(_ item: [String: AnyType]) throws -> [String: AnyType] {
        let document = CRUDMongoDatabaseProvider.convertToDocument(dictionary: item)
        let resultDocument = try collection.insert(document)
        
        return CRUDMongoDatabaseProvider.convertFromDocument(document: resultDocument)
    }

    func readItem(id: String) throws -> [String: AnyType]? {
        guard let objectID = try? ObjectId(id),
            let document = try collection.findOne(matching: "_id" == objectID) else {
            return nil
        }

        return CRUDMongoDatabaseProvider.convertFromDocument(document: document)
    }
}

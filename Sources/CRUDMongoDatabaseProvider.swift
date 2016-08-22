//
//  CRUDMongoDatabaseProvider.swift
//  SlackApp
//
//  Created by Claus Höfele on 22/08/16.
//
//

import Foundation
import MongoKitten

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

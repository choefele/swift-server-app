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

    private static func convertDocument(document: Document) -> [String: AnyType] {
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

    func readItems() throws -> [[String: AnyType]] {
        let documents = try collection.find()
        let items = documents.map(CRUDMongoDatabaseProvider.convertDocument)
        return items
    }

    func createItem() throws -> [String: AnyType] {
        return [String: AnyType]()
    }

    func readItem(id: String) throws -> [String: AnyType]? {
        guard let objectID = try? ObjectId(id),
            let document = try collection.findOne(matching: "_id" == objectID) else {
            return nil
        }

        return CRUDMongoDatabaseProvider.convertDocument(document: document)
    }
}

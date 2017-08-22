//
//  CRUDMongoDatabaseProvider.swift
//  SwiftServer
//
//  Created by Claus Höfele on 22/08/16.
//
//

import Foundation
import MongoKitten

public class CRUDMongoProvider {
    let collection: MongoKitten.Collection
    
    init(collection: MongoKitten.Collection) {
        self.collection = collection
    }
    
    func createItem(document: Document) throws -> Document? {
        let objectId = try collection.insert(document)
        return try collection.findOne("_id" == objectId)
    }
    
    func readItems(query: Query) throws -> [Document] {
        let documents = try collection.find(query)
        return Array(documents)
    }
    
    func readItem(objectId: ObjectId) throws -> Document? {
        let document = try collection.findOne("_id" == objectId)
        return document
    }
    
    func deleteItem(objectId: ObjectId) throws -> Bool {
        let numDocuments = try collection.remove("_id" == objectId, limitedTo: 1)
        return numDocuments == 1
    }
}

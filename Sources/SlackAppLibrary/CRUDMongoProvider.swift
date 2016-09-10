//
//  CRUDMongoDatabaseProvider.swift
//  SlackApp
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

//
//  CRUDHelper.swift
//  SlackApp
//
//  Created by Claus Höfele on 21.08.16.
//
//

import Foundation
import Kitura
import SwiftyJSON
import MongoKitten

// http://www.restapitutorial.com/lessons/httpmethods.html

protocol CRUDHandlerType {
    func handleItems(request: RouterRequest, response: RouterResponse, next: () -> Void) throws
    func handleItem(request: RouterRequest, response: RouterResponse, next: () -> Void) throws
}

class CRUDMongoHandler<Item>: CRUDHandlerType {
    let mongoProvider: CRUDMongoProvider
    let endpoint: CRUDEndpoint<Item>
    
    init(endpoint: CRUDEndpoint<Item>) {
        self.mongoProvider = CRUDMongoProvider(collection: endpoint.collection)
        self.endpoint = endpoint
    }
    
    func handleItems(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer {
            next()
        }
        
        if request.method == .get {
            let documents = try mongoProvider.readItems(query: Document())
            let items = documents.map(endpoint.generateItem)
            let jsonDictionaries = items.map(endpoint.generateJsonDictionary)
            response.send(json: JSON(["items": jsonDictionaries]))
        } else if request.method == .post {
            let document = try mongoProvider.createItem(document: endpoint.generateDocument(parameters: request.parameters))
            let item = endpoint.generateItem(document: document)
            let jsonDictionary = endpoint.generateJsonDictionary(item: item)
            response.status(.created).send(json: JSON(jsonDictionary))
        } else {
            try response.send(status: .notImplemented).end()
        }
    }
    
    func handleItem(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer {
            next()
        }
        
        if request.method == .get {
            guard let id = request.parameters["id"],
                let objectId = try? ObjectId(id),
                let document = try mongoProvider.readItem(objectId: objectId) else {
                    try response.send(status: .notFound).end()
                    return
            }
            
            let item = endpoint.generateItem(document: document)
            let jsonDictionary = endpoint.generateJsonDictionary(item: item)
            response.send(json: JSON(jsonDictionary))
        } else {
            try response.send(status: .notImplemented).end()
        }
    }
}

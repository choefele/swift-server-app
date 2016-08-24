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

class CRUDHandlerV3<Item>: CRUDHandlerType {
    let mongoProvider: CRUDMongoProviderV3
    let endpoint: EndPoint<Item>
    
    init(endpoint: EndPoint<Item>) {
        self.mongoProvider = CRUDMongoProviderV3(collection: endpoint.collection)
        self.endpoint = endpoint
    }
    
    func handleItems(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer {
            next()
        }
        
        if request.method == .get {
            let documents = try mongoProvider.readItems(query: Document())
            let items = documents.map(endpoint.generateItem)
            let itemsAsJsonDictionary = items.map(endpoint.generateJsonDictionary)
            response.send(json: JSON(["items": itemsAsJsonDictionary]))
        } else if request.method == .post {
            //            let itemAsDictionary = try databaseProvider.createItem([String : AnyType]())
            //            let item = Item.init(dictionary: itemAsDictionary)
            //            response.status(.created).send(json: JSON(item.dictionary))
        } else {
            try response.send(status: .notImplemented).end()
        }
    }
    
    func handleItem(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer {
            next()
        }
        
        if request.method == .get {
            //            guard let id = request.parameters["id"],
            //                let itemAsDictionary = try databaseProvider.readItem(id: id) else {
            //                    try response.send(status: .notFound).end()
            //                    return
            //            }
            //
            //            let item = Item.init(dictionary: itemAsDictionary)
            //            response.send(json: JSON(item.dictionary))
        } else {
            try response.send(status: .notImplemented).end()
        }
    }
}

class CRUDHandlerV2<DatabaseProvider: CRUDDatabaseProviderV2> {
    let databaseProvider: DatabaseProvider
    
    init(databaseProvider: DatabaseProvider) {
        self.databaseProvider = databaseProvider
    }
    
    func handleItems(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer {
            next()
        }
        
        if request.method == .get {
//            let items = try databaseProvider.readItems()
//            let itemsAsJSON = items.map({$0.dictionary})
//            response.send(json: JSON(["items": itemsAsJSON]))
        } else if request.method == .post {
//            let itemAsDictionary = try databaseProvider.createItem([String : AnyType]())
//            let item = Item.init(dictionary: itemAsDictionary)
//            response.status(.created).send(json: JSON(item.dictionary))
        } else {
            try response.send(status: .notImplemented).end()
        }
    }
    
    func handleItem(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer {
            next()
        }
        
        if request.method == .get {
//            guard let id = request.parameters["id"],
//                let itemAsDictionary = try databaseProvider.readItem(id: id) else {
//                    try response.send(status: .notFound).end()
//                    return
//            }
//            
//            let item = Item.init(dictionary: itemAsDictionary)
//            response.send(json: JSON(item.dictionary))
        } else {
            try response.send(status: .notImplemented).end()
        }
    }
}

class CRUDHandler<Item where Item: DictionaryConvertible> {
    let databaseProvider: CRUDDatabaseProvider

    init(databaseProvider: CRUDDatabaseProvider) {
        self.databaseProvider = databaseProvider
    }
    
    func handleItems(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer {
            next()
        }

        if request.method == .get {
            let itemsAsDictionaries = try databaseProvider.readItems()
            let items = itemsAsDictionaries.map(Item.init)
            let itemsAsJSON = items.map({$0.dictionary})
            response.send(json: JSON(["items": itemsAsJSON]))
        } else if request.method == .post {
            let itemAsDictionary = try databaseProvider.createItem([String : AnyType]())
            let item = Item.init(dictionary: itemAsDictionary)
            response.status(.created).send(json: JSON(item.dictionary))
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
                let itemAsDictionary = try databaseProvider.readItem(id: id) else {
                    try response.send(status: .notFound).end()
                    return
            }

            let item = Item.init(dictionary: itemAsDictionary)
            response.send(json: JSON(item.dictionary))
        } else {
            try response.send(status: .notImplemented).end()
        }
    }
}

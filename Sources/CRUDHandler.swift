//
//  CRUDHelper.swift
//  SlackApp
//
//  Created by Claus Höfele on 21.08.16.
//
//

import Foundation
import Kitura
import MongoKitten
import SwiftyJSON

// http://www.restapitutorial.com/lessons/httpmethods.html

class CRUDHandler<Item where Item: MongoConvertible, Item: DictionaryConvertible> {
    let databaseProvider: CRUDDatabaseProvider
    let collection: MongoKitten.Collection

    init(collection: MongoKitten.Collection, databaseProvider: CRUDDatabaseProvider) {
        self.collection = collection
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
            try createItem()
        } else {
            try response.send(status: .notFound).end()
        }
    }
    
    private func createItem() throws {
        var document = Document()
        document["name"] = "name123"
        try collection.insert(document)
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
            try response.send(status: .notFound).end()
        }
    }
}

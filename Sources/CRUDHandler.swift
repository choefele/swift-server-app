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

// http://www.restapitutorial.com/lessons/httpmethods.html

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
            try response.send(status: .created).send(json: JSON(item.dictionary))
        } else {
            try response.send(status: .notFound).end()
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
            try response.send(status: .notFound).end()
        }
    }
}

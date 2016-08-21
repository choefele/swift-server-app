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
    let collection: MongoKitten.Collection
    
    init(collection: MongoKitten.Collection) {
        self.collection = collection
    }
    
    func handleItems(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        if request.method == .get {
            let items = try getItems()
            let itemsAsJSON = JSON(["items": items.map { $0.dictionary }])
            response.send(json: itemsAsJSON)
        } else if request.method == .post {
            try createItem()
        } else {
            try response.send(status: .notFound).end()
        }
        next()
    }
    
    func getItems() throws -> [Item] {
        let items: [Item] = try collection.find().map(Item.init)
        return items
    }
    
    func createItem() throws {
        var document = Document()
        document["name"] = "name123"
        try collection.insert(document)
    }
    
    func handleItem(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        try response.send(status: .notFound).end()
        next()
    }
}

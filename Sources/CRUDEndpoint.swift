//
//  CRUDEndpoint.swift
//  SlackApp
//
//  Created by Claus Höfele on 25.08.16.
//
//

import Foundation
import MongoKitten

struct CRUDEndpoint<Item> {
    let collection: MongoKitten.Collection
    var generateDocument: (parameters: [String: String]) -> Document
    var generateItem: (document: Document) -> Item
    var generateJsonDictionary: (item: Item) -> [String: AnyType]
}

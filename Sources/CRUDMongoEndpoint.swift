//
//  CRUDEndpoint.swift
//  SlackApp
//
//  Created by Claus Höfele on 25.08.16.
//
//

import Foundation
import MongoKitten

struct CRUDMongoEndpoint {
    let collection: MongoKitten.Collection
    var generateDocument: (parameters: [String: String]) -> Document
    var generateJsonDictionary: (document: Document) -> [String: AnyType]
}

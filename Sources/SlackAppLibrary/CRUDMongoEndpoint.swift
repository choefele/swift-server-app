//
//  CRUDEndpoint.swift
//  SlackApp
//
//  Created by Claus Höfele on 25.08.16.
//
//

import Foundation
import MongoKitten

#if os(Linux)
    public typealias AnyType = Any
#else
    public typealias AnyType = AnyObject
#endif

public struct CRUDMongoEndpoint {
    public init(collection: MongoKitten.Collection, generateDocument: (parameters: [String: String]) -> Document, generateJsonDictionary: (document: Document) -> [String: AnyType]) {
        self.collection = collection
        self.generateDocument = generateDocument
        self.generateJsonDictionary = generateJsonDictionary
    }
    
    public let collection: MongoKitten.Collection
    public var generateDocument: (parameters: [String: String]) -> Document
    public var generateJsonDictionary: (document: Document) -> [String: AnyType]
}

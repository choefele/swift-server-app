//
//  CRUDDatabaseProvider.swift
//  SlackApp
//
//  Created by Claus Höfele on 22/08/16.
//
//

import Foundation

protocol CRUDDatabaseProvider {
    func readItems() throws -> [[String: AnyType]]
    func createItem(_ item: [String: AnyType]) throws -> [String: AnyType]
    func readItem(id: String) throws -> [String: AnyType]?
}

protocol CRUDDatabaseProviderV2 {
    associatedtype Item
    
    func readItems() throws -> [Item]
    func createItem(_ item: Item) throws -> Item
    func readItem(id: String) throws -> Item?
}

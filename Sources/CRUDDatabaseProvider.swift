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
    func createItem() throws -> [String: AnyType]
    func readItem(id: String) throws -> [String: AnyType]?
}

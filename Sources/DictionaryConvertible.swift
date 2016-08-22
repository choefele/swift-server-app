//
//  JSONConvertible.swift
//  SlackApp
//
//  Created by Claus Höfele on 21.08.16.
//
//

import Foundation

protocol DictionaryConvertible {
    init(dictionary: [String : AnyType])
    var dictionary: [String: AnyType] {get}
}

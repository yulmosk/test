//
//  ListWithData.swift
//  Example
//
//  Created by Yulia Moskaleva on 15/03/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import Foundation

struct ListWithData: Codable {
    let data: [Element]
    let view: [String]
}

struct Element: Codable {
    let name: String
    let data : ElementData
}

struct ElementData: Codable {
    let text: String?
    let url: String?
    let selectedId: Int?
    let variants: [Variant]?
}

struct Variant: Codable {
    let id: Int
    let text: String
}

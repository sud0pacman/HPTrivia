//
//  Book.swift
//  HPTrivia
//
//  Created by Muhammad on 22/05/26.
//

struct Book: Codable, Identifiable {
    let id: Int
    let image: String
    let questions: [Question]
    var status: BookStatus
}

enum BookStatus: Codable {
    case active, inactive, locked
}

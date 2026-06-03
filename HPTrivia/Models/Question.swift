//
//  Question.swift
//  HPTrivia
//
//  Created by Muhammad on 21/05/26.
//

struct Question: Codable {
    let id: Int
    let question: String
    let answer: String
    let wrong: [String]
    let book: Int
    let hint: String
}

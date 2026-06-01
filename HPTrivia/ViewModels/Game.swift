//
//  Game.swift
//  HPTrivia
//
//  Created by Muhammad on 22/05/26.
//

import SwiftUI

@Observable
class Game {
    var bookQuestion = BookQuestions()
    
    var gameScore = 0
    var questionScore = 0
    var recentScores = Array(repeating: 0, count: 3)
    
    var activeQuestion: [Question] = []
    var answeredQuestions: [Int] = []
    var currentQuestion = try! JSONDecoder().decode([Question].self, from: Data(contentsOf: Bundle.main.url(forResource: "trivia", withExtension: "json")!))[0]
    var answers: [String] = []
    
    func startGame() {
        for book in bookQuestion.books {
            for question in book.questions {
                activeQuestion.append(question)
            }
        }
        
        newQuestion()
    }
    
    func newQuestion() {
        if answeredQuestions.count == activeQuestion.count {
            answeredQuestions = []
        }
        
        currentQuestion = activeQuestion.randomElement()!
        while answeredQuestions.contains(currentQuestion.id) {
            currentQuestion = activeQuestion.randomElement()!
        }
        
        answers = []
        answers.append(currentQuestion.answer)
        
        for answer in currentQuestion.wrong {
            answers.append(answer)
        }
        
        answers.shuffle()
        
        questionScore = 5
    }
    
    func correct() {
        answeredQuestions.append(currentQuestion.id)
        
        withAnimation {
            gameScore += questionScore
        }
    }
    
    func endGame() {
        recentScores[2] = recentScores[1]
        recentScores[1] = recentScores[0]
        recentScores[0] = gameScore
        
        gameScore = 0
        activeQuestion = []
        answeredQuestions = []
    }
}

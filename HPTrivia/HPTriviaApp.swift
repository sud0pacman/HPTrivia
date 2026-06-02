//
//  HPTriviaApp.swift
//  HPTrivia
//
//  Created by Muhammad on 21/05/26.
//

import SwiftUI

@main
struct HPTriviaApp: App {
    private var game = Game()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(game)
        }
    }
}

/**
 App Development
  ✅ Game Intro Screen
  ✅ Gameplay Screen
  🟦 Game logic (question, score, etc.)
  ✅ Celebration
  ✅ Audio
  ✅ Animations
  - In app purchases
  - Store
  ✅ Instruction screen
  🟦 Books
  - Persist scores
 ✅
 */

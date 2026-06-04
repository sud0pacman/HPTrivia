//
//  RecentScores.swift
//  HPTrivia
//
//  Created by G'aniyev Muhammad on 22/05/26.
//

import SwiftUI

struct RecentScores: View {
    @Environment(Game.self) private var game
    @Binding var animateViewsIn: Bool
    
    private let indices: [Int] = Array(0..<3)
    
    var body: some View {
        VStack {
            if animateViewsIn {
                VStack {
                    Text("Recent Scores")
                        .font(.title2)
                    
                    ForEach(indices, id: \.self) { i in
                        let score = game.recentScores[i]
                        Text("\(score.name): \(score.score)")
                            .font(.title2)
                    }
                    
                }
                .font(.title)
                .foregroundStyle(.white)
                .padding(.horizontal)
                .background(.black.opacity(0.7))
                .clipShape(.rect(cornerRadius: 15))
                .transition(.opacity)
            }
        }
        .animation(.linear(duration: 1).delay(4), value: animateViewsIn)
    }
}

#Preview {
    RecentScores(animateViewsIn: .constant(true))
        .environment(Game())
}

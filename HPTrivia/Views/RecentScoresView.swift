//
//  RecentScoresView.swift
//  HPTrivia
//
//  Created by Muhammad on 04/06/26.
//

import SwiftUI

struct RecentScoresView: View {
    @Environment(Game.self) var game
    @Environment(\.dismiss) var dismiss
    @State private var isPresented: Bool = false
    @State private var animateItems = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.parchment)
                    .resizable()
                    .ignoresSafeArea()
                    .background(.brown)
            
                if animateItems {
                    List(game.recentScores, id: \.self) { score in
                        HStack {
                            Text("\(score.name)")
                            Spacer()
                            Text("\(score.score)")
                        }
                        .foregroundColor(.white)
                        .listRowBackground(Color.brown.mix(with: .black, by: 0.3))
                        .listRowSeparatorTint(.brown)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .scrollContentBackground(.hidden)
                    .background(.clear)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                   Button("Cancel") {
                       dismiss()
                   }
               }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    animateItems = true
                }
            }
        }
    }
}

struct FlyAwayItem: View {
    let score: PlayerScore
    let itemOffset: CGFloat
    
    var body: some View {
        HStack {
            Text("\(score.name)")
            Spacer()
            Text("\(score.score)")
        }
    }
}

#Preview {
    RecentScoresView()
        .environment(Game())
}

//
//  GameTitle.swift
//  HPTrivia
//
//  Created by G'aniyev Muhammad on 22/05/26.
//

import SwiftUI

struct GameTitle: View {
    @Binding var animationViewsIn: Bool
    
    var body: some View {
        VStack {
            if animationViewsIn {
                VStack {
                    Image(systemName: "bolt.fill")
                        .font(.largeTitle)
                    
                    Text("HP")
                        .font(.custom("PartyletPlain", size: 70))
                        .padding(.bottom, -50)
                    
                    Text("Trivia")
                        .font(.custom("PartyletPlain", size: 60))
                }
                .padding(.top, 70)
                .transition(.move(edge: .top))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(2), value: animationViewsIn)
    }
}

#Preview {
    GameTitle(animationViewsIn: .constant(true))
}

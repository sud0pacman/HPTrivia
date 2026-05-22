//
//  GamePlay.swift
//  HPTrivia
//
//  Created by Muhammad on 22/05/26.
//

import SwiftUI

struct GamePlay: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                    .overlay {
                        Rectangle()
                            .foregroundStyle(.black.opacity(0.8))
                    }
                
                VStack {
                    // MARK: Controls
                    
                    // MARK: Questions
                    
                    // MARK: Hints
                    
                    // MARK: Answers
                }
                .frame(width: geo.size.width, height: geo.size.height)
                
                // MARK: Celebration
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    GamePlay()
}

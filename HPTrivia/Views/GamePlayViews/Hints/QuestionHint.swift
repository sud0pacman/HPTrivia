//
//  QuestionHint.swift
//  HPTrivia
//
//  Created by Muhammad on 04/06/26.
//

import SwiftUI
import AVKit

struct QuestionHint: View {
    @Environment(Game.self) var game
    let animateViewsIn: Bool
    let geo: GeometryProxy
    @Binding var revealHint: Bool
    private let audioHelper = AudioHelper()
    
    var body: some View {
        VStack {
            if animateViewsIn {
                Image(systemName: "questionmark.app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundStyle(.cyan)
                    .padding()
                    .transition(.offset(x: -geo.size.width / 2))
                    .phaseAnimator([false, true]) { content, phase in
                        content
                            .rotationEffect(.degrees(phase ? -13 : -17))
                    } animation: { _ in
                            .easeInOut(duration: 0.7)
                    }
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 1)) {
                            revealHint = true
                        }
                        audioHelper.playFlipSound()
                        game.questionScore -= 1
                    }
                    .rotation3DEffect(.degrees(revealHint ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                    .scaleEffect(revealHint ? 5 : 1)
                    .offset(x: revealHint ? geo.size.width / 2 : 0)
                    .opacity(revealHint ? 0 : 1)
                    .overlay {
                        Text(game.currentQuestion.hint)
                            .padding(.leading, 20)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .opacity(revealHint ? 1 : 0)
                            .scaleEffect(revealHint ? 1.33 : 0)
                    }
            }
        }
        .animation(.easeOut(duration: animateViewsIn ? 1.5 : 0).delay(animateViewsIn ? 0.5 : 0), value: animateViewsIn)
    }
}

#Preview {
    GeometryReader { geo in
        QuestionHint(animateViewsIn: false, geo: geo, revealHint: .constant(false))
    }
}

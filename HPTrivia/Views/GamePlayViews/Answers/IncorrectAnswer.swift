//
//  IncorrectAnswer.swift
//  HPTrivia
//
//  Created by Muhammad on 04/06/26.
//

import SwiftUI

struct IncorrectAnswer: View {
    let animateViewsIn: Bool
    let geo: GeometryProxy
    @Namespace var namespace
    @Binding var wrongAnswersTapped: [String]
    @Environment(Game.self) var game
    let answer: String
    private let audioHelper = AudioHelper()
    
    var body: some View {
        VStack {
            if animateViewsIn {
                Button {
                    withAnimation(.easeOut(duration: 1)) {
                        wrongAnswersTapped.append(answer)
                    }
                    
                    audioHelper.playWrongSound()
                    
                    game.questionScore -= 1
                } label : {
                    Text(answer)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .frame(width: geo.size.width / 2.15, height: 80)
                        .background(wrongAnswersTapped.contains(answer) ? .red.opacity(0.5) : .green.opacity(0.5))
                        .clipShape(.rect(cornerRadius: 25))
                }
                .transition(.scale)
                .sensoryFeedback(.error, trigger: wrongAnswersTapped)
                .disabled(wrongAnswersTapped.contains(answer))
            }
        }
        .animation(.easeInOut(duration: animateViewsIn ? 1 : 0).delay(animateViewsIn ? 1.5 : 0), value: animateViewsIn)
    }
}

#Preview {
    GeometryReader { geo in
        IncorrectAnswer(animateViewsIn: true, geo: geo, wrongAnswersTapped: .constant([String]()), answer: "Default Answer")
            .environment(Game())
    }
}

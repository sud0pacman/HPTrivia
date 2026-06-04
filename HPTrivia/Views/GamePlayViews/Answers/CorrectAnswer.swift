//
//  CorrectAnswer.swift
//  HPTrivia
//
//  Created by Muhammad on 04/06/26.
//

import SwiftUI

struct CorrectAnswer: View {
    let animateViewsIn: Bool
    let geo: GeometryProxy
    let namespace: Namespace.ID
    @Binding var tappedCorrectAnswer: Bool
    @Environment(Game.self) var game
    let answer: String
    private let audioHelper = AudioHelper()
    
    var body: some View {
        VStack {
            if animateViewsIn {
                if !tappedCorrectAnswer {
                    Button {
                        withAnimation {
                            tappedCorrectAnswer = true
                        }
                        
                        audioHelper.playCorrectSound()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            game.correct()
                        }
                    } label : {
                        Text(answer)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .frame(width: geo.size.width / 2.15, height: 80)
                            .background(.green.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 25))
                            .matchedGeometryEffect(id: 1, in: namespace)
                    }
                    .transition(.asymmetric(insertion: .scale, removal: .scale(scale: 15).combined(with: .opacity)))
                }
            }
        }
        .animation(.easeOut(duration: animateViewsIn ? 1 : 0).delay(animateViewsIn ? 1.5 : 0), value: animateViewsIn)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @Namespace private var previewNamespace
        
        var body: some View {
            GeometryReader { geo in
                CorrectAnswer(animateViewsIn: true, geo: geo, namespace: previewNamespace, tappedCorrectAnswer: .constant(false), answer: "Default Answer")
            }
        }
    }
    
    return PreviewWrapper().environment(Game())
}

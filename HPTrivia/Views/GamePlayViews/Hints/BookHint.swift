//
//  BookHintView.swift
//  HPTrivia
//
//  Created by Muhammad on 04/06/26.
//

import SwiftUI

struct BookHint: View {
    @Environment(Game.self) var game
    let animateViewsIn: Bool
    let geo: GeometryProxy
    @Binding var revealBook: Bool
    private let audioHelper = AudioHelper()
    
    var body: some View {
        VStack {
            if animateViewsIn {
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundStyle(.cyan)
                    .overlay {
                        Image(systemName: "book.closed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .transition(.offset(x: geo.size.width / 2))
                    .phaseAnimator([false, true]) { content, phase in
                        content
                            .rotationEffect(.degrees(phase ? 13 : 17))
                    } animation: { _ in
                            .easeInOut(duration: 0.7)
                    }
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 1)) {
                            revealBook = true
                        }
                        audioHelper.playFlipSound()
                        game.questionScore -= 1
                    }
                    .rotation3DEffect(.degrees(revealBook ? -1440 : 0), axis: (x: 0, y: 1, z: 0))
                    .scaleEffect(revealBook ? 5 : 1)
                    .offset(x: revealBook ? -geo.size.width / 2 : 0)
                    .opacity(revealBook ? 0 : 1)
                    .overlay {
                        Image("hp\(game.currentQuestion.book)")
                            .resizable()
                            .scaledToFit()
                            .padding(.trailing, 20)
                            .opacity(revealBook ? 1 : 0)
                            .scaleEffect(revealBook ? 1.33 : 0)
                    }
            }
        }
        .animation(.easeOut(duration: animateViewsIn ? 1.5 : 0).delay(animateViewsIn ? 0.5 : 0), value: animateViewsIn)
    }
}

#Preview {
    GeometryReader { geo in
        BookHint(animateViewsIn: true, geo: geo, revealBook: .constant(false))
            .environment(Game())
    }
}

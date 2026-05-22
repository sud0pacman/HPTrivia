//
//  PlayButton.swift
//  HPTrivia
//
//  Created by G'aniyev Muhammad on 22/05/26.
//

import SwiftUI

struct PlayButton: View {
    @State private var scalePlayButton = false
    @Binding var animationViewsIn: Bool
    @Binding var playGame: Bool
    
    let geo: GeometryProxy
    
    var body: some View {
        VStack {
            if animationViewsIn {
                Button {
                    playGame.toggle()
                } label: {
                    Text("Play")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 50)
                        .background(.brown)
                        .clipShape(.rect(cornerRadius: 7))
                        .shadow(radius: 5)
                        .scaleEffect(scalePlayButton ? 1.1 : 1)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                                scalePlayButton.toggle()
                            }
                        }
                }
                .transition(.offset(y: geo.size.height/3))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(2.0), value: animationViewsIn)
    }
}

#Preview {
    GeometryReader { geo in
        PlayButton(animationViewsIn: .constant(true), playGame: .constant(false), geo: geo)
    }
}

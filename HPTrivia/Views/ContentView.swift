//
//  ContentView.swift
//  HPTrivia
//
//  Created by Muhammad on 21/05/26.
//

import SwiftUI

struct ContentView: View {
    @State private var animationViewsIn = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .padding(.top, 3)
                    .phaseAnimator([false, true]) { content, phase in
                        let xOffset = geo.size.width / 1.1
                        content
                            .offset(x: phase ? xOffset : -xOffset)
                    } animation: { _ in
                            .linear(duration: 60)
                    }
                
                VStack {
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
                    
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                animationViewsIn = true
            }
        }
    }
}

#Preview {
    ContentView()
}

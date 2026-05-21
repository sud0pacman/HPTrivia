//
//  ContentView.swift
//  HPTrivia
//
//  Created by Muhammad on 21/05/26.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State private var animationViewsIn = false
    @State private var scalePlayButton = false
    
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
                    
                    Spacer()
                    
                    VStack {
                        if animationViewsIn {
                            Button {
                                // Play a game
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
                    .animation(.easeOut(duration: 0.7).delay(2), value: animationViewsIn)
                    
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            animationViewsIn = true
//            playAudio()
        }
    }
    
    private func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
}

#Preview {
    ContentView()
}

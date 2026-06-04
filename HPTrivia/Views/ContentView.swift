//
//  ContentView.swift
//  HPTrivia
//
//  Created by Muhammad on 21/05/26.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @Environment(Game.self) var game
    @State private var audioPlayer: AVAudioPlayer!
    @State private var animationViewsIn = false
    @State private var playGame = false
    @State private var name = ""
    @State private var openGameScreen: Bool = false
    @State private var openRecentScores: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                AnimatedBackground(geo: geo)
                
                VStack {
                    GameTitle(animationViewsIn: $animationViewsIn)
                    
                    Spacer()
                    
                    RecentScores(animateViewsIn: $animationViewsIn)
                        .onTapGesture {
                            openRecentScores = true
                        }
                    
                    Spacer()
                    
                    ButtonBar(animationViewsIn: $animationViewsIn, playGame: $playGame, geo: geo)
                    
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            animationViewsIn = true
            playAudio()
        }
        .alert("Enter your name", isPresented: $playGame) {
            TextField("John Doe", text: $name)
                .textInputAutocapitalization(.words)
            
            Button("Cancel", role: .cancel) {
                withAnimation {
                    playGame = false
                }
            }
            Button("Save", role: .confirm) {
                game.playerName = name.isEmpty ? "Guest" : name
                openGameScreen = !name.isEmpty
            }
        } message: {
            Text("Please type your display name below.")
        }
        .fullScreenCover(isPresented: $openGameScreen) {
            GamePlay()
                .onAppear {
                    audioPlayer.setVolume(0, fadeDuration: 2)
                }
                .onDisappear {
                    audioPlayer.setVolume(1, fadeDuration: 3)
                }
        }
        .fullScreenCover(isPresented: $openRecentScores) {
            RecentScoresView()
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
        .environment(Game())
}

//
//  GamePlay.swift
//  HPTrivia
//
//  Created by Muhammad on 22/05/26.
//

import SwiftUI
import AVKit

struct GamePlay: View {
    @Environment(Game.self) var game
    @Environment(\.dismiss) var dismiss
    @Namespace private var namespace
    
    @State private var musicPlayer: AVAudioPlayer!
    
    @State private var animateViewsIn: Bool = false
    
    @State private var revealHint = false
    @State private var revealBook = false
    
    @State private var tappedCorrectAnswer = false
    @State private var wrongAnswersTapped: [String] = []
    
    @State private var movePointsToScore = false
    
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
                    HStack {
                        Button("End Game") {
                            game.endGame()
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        
                        Spacer()
                        
                        Text("Score: \(game.gameScore)")
                    }
                    .padding()
                    .padding(.vertical, 30)
                    
                    VStack {
                        // MARK: Questions
                        VStack {
                            if animateViewsIn {
                                Text(game.currentQuestion.question)
                                    .font(.custom("PartyLetPlain", size: 50))
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .transition(.scale)
                            }
                        }
                        .animation(.easeInOut(duration: animateViewsIn ? 2 : 0), value: animateViewsIn)
                        
                        Spacer()
                        
                        // MARK: Hints
                        HStack {
                            QuestionHint(animateViewsIn: animateViewsIn, geo: geo, revealHint: $revealHint)
                            
                            Spacer()
                            
                            BookHint(animateViewsIn: animateViewsIn, geo: geo, revealBook: $revealBook)
                        }
                        .padding()
                    
                        // MARK: Answers
                        LazyVGrid(columns: [GridItem(), GridItem()]) {
                            ForEach(game.answers, id: \.self) { answer in
                                if answer == game.currentQuestion.answer {
                                    CorrectAnswer(animateViewsIn: animateViewsIn, geo: geo, namespace: namespace, tappedCorrectAnswer: $tappedCorrectAnswer, answer: answer)
                                } else {
                                    IncorrectAnswer(animateViewsIn: animateViewsIn, geo: geo, wrongAnswersTapped: $wrongAnswersTapped, answer: answer)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .disabled(tappedCorrectAnswer)
                    .opacity(tappedCorrectAnswer ? 0.1 : 1)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .foregroundStyle(.white)
                
                // MARK: Celebration
                VStack {
                    Spacer()
                    
                    VStack {
                        if tappedCorrectAnswer {
                            Text("\(game.questionScore)")
                                .font(.largeTitle)
                                .padding(.top, 50)
                                .transition(.offset(y: -geo.size.height / 4))
                                .offset(x: movePointsToScore ? geo.size.width / 2.3 : 0,
                                        y: movePointsToScore ? -geo.size.height / 13 : 0)
                                .opacity(movePointsToScore ? 0 : 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1).delay(animateViewsIn ? 3 : 0)) {
                                        movePointsToScore = true
                                    }
                                }
                        }
                    }
                    .animation(.easeInOut(duration: animateViewsIn ? 1 : 0).delay(animateViewsIn ? 2 : 0), value: tappedCorrectAnswer)
                    
                    Spacer()
                    
                    VStack {
                        if tappedCorrectAnswer {
                            Text("Brilliant")
                                .font(.custom("PartyLetPlain", size: 100))
                                .transition(.scale.combined(with: .offset(y: -geo.size.height / 2)))
                        }
                    }
                    .animation(.easeOut(duration: tappedCorrectAnswer ? 1 : 0).delay(tappedCorrectAnswer ? 1 : 0), value: tappedCorrectAnswer)
                    
                    Spacer()
                    
                    if tappedCorrectAnswer {
                        Text(game.currentQuestion.answer)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .frame(width: geo.size.width / 2.15, height: 80)
                            .background(.green.opacity(0.7))
                            .clipShape(.rect(cornerRadius: 25))
                            .scaleEffect(2)
                            .matchedGeometryEffect(id: 1, in: namespace)
                    }
                    
                    Spacer()
                    
                    VStack {
                        if tappedCorrectAnswer {
                            Button("Next Level >") {
                                animateViewsIn = false
                                revealHint = false
                                revealBook = false
                                tappedCorrectAnswer = false
                                wrongAnswersTapped = []
                                movePointsToScore = false
                                game.newQuestion()
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    animateViewsIn = true
                                }
                            }
                            .font(.largeTitle)
                            .buttonStyle(.borderedProminent)
                            .tint(.blue.opacity(0.5))
                            .transition(.offset(y: geo.size.height / 3))
                            .phaseAnimator([false, true], ) { content, phase in
                                content
                                    .scaleEffect(phase ? 1.2 : 1)
                            } animation: { _ in
                                    .easeInOut(duration: 1.3)
                            }
                        }
                    }
                    .animation(.easeInOut(duration: tappedCorrectAnswer ? 2.7 : 0).delay(tappedCorrectAnswer ? 2.7 : 0), value: tappedCorrectAnswer)
                    
                    Spacer()
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .foregroundStyle(.white)
        }
        .ignoresSafeArea()
        .onAppear {
            game.startGame()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                animateViewsIn = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                playMusic()
            }
        }
    }
    
    private func playMusic() {
        let songs = ["let-the-mystery-unfold", "spellcraft", "hiding-place-in-the-forest", "deep-in-the-dell" ]
        
        let song = songs.randomElement()!
        
        let sound = Bundle.main.path(forResource: song, ofType: "mp3")
        musicPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        musicPlayer.numberOfLoops = -1
        musicPlayer.volume = 0.1
        musicPlayer.play()
    }
    
}

#Preview {
    GamePlay()
        .environment(Game())
}

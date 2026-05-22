//
//  SelectBooks.swift
//  HPTrivia
//
//  Created by Muhammad on 22/05/26.
//

import SwiftUI

struct SelectBooks: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(Game.self) private var game
    
    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                Text("Which books would you like to see questions from?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(game.bookQuestion.books) { book in
                            if book.status == .active {
                                ZStack(alignment: .bottomTrailing) {
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundStyle(.green)
                                        .shadow(radius: 1)
                                        .padding(3)
                                }
                            } else if book.status == .inactive {
                                ZStack {
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                }
                            } else {
                                ZStack {
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                }
                            }
                        }
                    }
                    .padding()
                }
        
                Button("Done") {
                    dismiss()
                }
                .font(.largeTitle)
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
            }
        }
    }
}

#Preview {
    SelectBooks()
        .environment(Game())
}

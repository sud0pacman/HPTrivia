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
    
    private var store = Store()
    
    private var activeBooks: Bool {
        for book in game.bookQuestion.books {
            if book.status == .active {
                return true
            }
        }
        
        return false
    }
    
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
                            if book.status == .active || (book.status == .locked && store.purchased.contains(book.image)) {
                                ActiveBook(book: book)
                                    .task {
                                        game.bookQuestion.changeStatus(of: book.id, to: .active)
                                    }
                                    .onTapGesture {
                                        game.bookQuestion.changeStatus(of: book.id, to: .inactive)
                                    }
                            } else if book.status == .inactive {
                                InactiveBook(book: book)
                                    .onTapGesture {
                                        game.bookQuestion.changeStatus(of: book.id, to: .active)
                                    }
                            } else {
                                LockedBook(book: book)
                                    .onTapGesture {
                                        let product = store.products[book.id - 4]
                                        
                                        Task {
                                            await store.purchase(product)
                                        }
                                    }
                            }
                        }
                    }
                    .padding()
                }
                
                if !activeBooks {
                    Text("You must select at least 1 book.")
                        .multilineTextAlignment(.center)
                }
        
                Button("Done") {
                    dismiss()
                }
                .font(.largeTitle)
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .disabled(!activeBooks)
            }
        }
        .interactiveDismissDisabled(!activeBooks)
        .task {
            await store.loadProducts()
        }
    }
}

#Preview {
    SelectBooks()
        .environment(Game())
}

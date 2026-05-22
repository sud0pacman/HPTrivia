//
//  InactiveBook.swift
//  HPTrivia
//
//  Created by Muhammad on 22/05/26.
//

import SwiftUI

struct InactiveBook: View {
    @State var book: Book
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(book.image)
                .resizable()
                .scaledToFit()
                .shadow(radius: 7)
                .overlay {
                    Rectangle()
                        .fill(Color.black.opacity(0.3))
                }
            
            Image(systemName: "circle")
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.green.opacity(0.5))
                .shadow(radius: 1)
                .padding(3)
        }
    }
}

#Preview {
    InactiveBook(book: BookQuestions().books[0])
}

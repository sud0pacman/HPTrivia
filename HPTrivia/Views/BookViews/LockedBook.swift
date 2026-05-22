//
//  LockedBook.swift
//  HPTrivia
//
//  Created by Muhammad on 22/05/26.
//

import SwiftUI

struct LockedBook: View {
    @State var book: Book
    
    var body: some View {
        ZStack {
            Image(book.image)
                .resizable()
                .scaledToFit()
                .shadow(radius: 7)
                .overlay {
                    Rectangle()
                        .fill(Color.black.opacity(0.75))
                }
            
            Image(systemName: "lock.fill")
                .font(.largeTitle)
                .imageScale(.large)
                .shadow(color: .white, radius: 3)
        }
    }
}

#Preview {
    LockedBook(book: BookQuestions().books[0])
}

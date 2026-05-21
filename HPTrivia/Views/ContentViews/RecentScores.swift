//
//  RecentScores.swift
//  HPTrivia
//
//  Created by G'aniyev Muhammad on 22/05/26.
//

import SwiftUI

struct RecentScores: View {
    @Binding var animationViewsIn: Bool
    
    var body: some View {
        VStack {
            if animationViewsIn {
                VStack {
                    Text("Recent Scores")
                        .font(.title2)
                    
                    Text("33")
                    Text("27")
                    Text("15")
                }
                .font(.title)
                .foregroundStyle(.white)
                .padding(.horizontal)
                .background(.black.opacity(0.7))
                .clipShape(.rect(cornerRadius: 15))
                .transition(.opacity)
            }
        }
        .animation(.linear(duration: 1).delay(4), value: animationViewsIn)
    }
}

#Preview {
    RecentScores(animationViewsIn: .constant(true))
}

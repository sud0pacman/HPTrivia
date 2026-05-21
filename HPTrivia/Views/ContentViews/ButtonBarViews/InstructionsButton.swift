//
//  InstructionsButton.swift
//  HPTrivia
//
//  Created by G'aniyev Muhammad on 22/05/26.
//

import SwiftUI

struct InstructionsButton: View {
    @State private var showInstructions: Bool = false
    @Binding var animationViewsIn: Bool
    
    let geo: GeometryProxy
    
    var body: some View {
        VStack {
            if animationViewsIn {
                Button {
                    showInstructions.toggle()
                } label: {
                    Image(systemName: "info.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                }
                .transition(.offset(x: -geo.size.width / 4))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(2.7), value: animationViewsIn)
        .sheet(isPresented: $showInstructions) {
            Instructions()
        }
    }
}

#Preview {
    GeometryReader { geo in
        InstructionsButton(animationViewsIn: .constant(true), geo: geo)
    }
}

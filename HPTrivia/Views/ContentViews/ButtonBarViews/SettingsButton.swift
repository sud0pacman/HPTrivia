//
//  SettingsButton.swift
//  HPTrivia
//
//  Created by G'aniyev Muhammad on 22/05/26.
//

import SwiftUI

struct SettingsButton: View {
    @State private var showSettings = false
    @Binding var animationViewsIn: Bool
    
    let geo: GeometryProxy
    
    var body: some View {
        VStack {
            if animationViewsIn {
                Button {
                    showSettings.toggle()
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                }
                .transition(.offset(x: geo.size.width / 4))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(2.7), value: animationViewsIn)
        .sheet(isPresented: $showSettings) {
            SelectBooks()
        }
    }
}

#Preview {
    GeometryReader { geo in
        SettingsButton(animationViewsIn: .constant(true), geo: geo)
            .environment(Game())
    }
}

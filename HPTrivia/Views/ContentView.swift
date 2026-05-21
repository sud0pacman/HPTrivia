//
//  ContentView.swift
//  HPTrivia
//
//  Created by Muhammad on 21/05/26.
//

import SwiftUI

struct ContentView: View {
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
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}

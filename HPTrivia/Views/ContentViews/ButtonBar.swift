//
//  ButtonBar.swift
//  HPTrivia
//
//  Created by G'aniyev Muhammad on 22/05/26.
//

import SwiftUI

struct ButtonBar: View {
    @Binding var animationViewsIn: Bool
    
    let geo: GeometryProxy
    
    var body: some View {
        HStack {
            
            Spacer()
            
            InstructionsButton(animationViewsIn: $animationViewsIn, geo: geo)
            
            Spacer()
            
            PlayButton(animationViewsIn: $animationViewsIn, geo: geo)
            
            Spacer()
            
            SettingsButton(animationViewsIn: $animationViewsIn, geo: geo)
            
            Spacer()
        }
        .frame(width: geo.size.width)
    }
}

#Preview {
    GeometryReader { geo in
        ButtonBar(animationViewsIn: .constant(true), geo: geo)
    }
}

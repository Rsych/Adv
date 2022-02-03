//
//  ViewModifierExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/02/03.
//

import SwiftUI
struct ButtonViewModifier: ViewModifier {
    let backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}
extension View {
    func withDefaultButtonFormatting(color: Color = .blue) -> some View {
        modifier(ButtonViewModifier(backgroundColor: color))
    }
}

struct ViewModifierExamp: View {
    var body: some View {
        VStack(spacing: 10.0) {
            Text("Hello")
                .font(.headline)
                .modifier(ButtonViewModifier(backgroundColor: .orange))
            Text("World")
                .font(.title)
                .withDefaultButtonFormatting(color: .red)
            Text("Test")
                .font(.subheadline)
                .withDefaultButtonFormatting()
        } //: VStack
        .padding()
    }
}

struct ViewModifierExamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierExamp()
    }
}

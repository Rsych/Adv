//
//  ButtonStyleExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/02/03.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    init(scaleAmount: CGFloat) {
        self.scaleAmount = scaleAmount
    }
    let scaleAmount: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? scaleAmount : 1.0)
//            .brightness(configuration.isPressed ? 0.5 : 0)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
extension View {
    func withPressedStyle(scaleAmount: CGFloat = 0.9) -> some View {
        self.buttonStyle(PressableButtonStyle(scaleAmount: scaleAmount))
    }
}

struct ButtonStyleExamp: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Click here")
                .font(.headline)
                .withDefaultButtonFormatting(color: .orange)
        }
//        .buttonStyle(PressableButtonStyle())
        .withPressedStyle(scaleAmount: 0.2)
//        .withPressedStyle()
        .padding()
    }
}

struct ButtonStyleExamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleExamp()
    }
}

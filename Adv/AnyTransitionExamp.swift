//
//  AnyTransitionExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/02/03.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    let rotation: Double
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0)
    }
}
extension AnyTransition {
    static var rotating: AnyTransition {
        // cuz we're under AnyTransition extension, no need to
        // add return nor AnyTransition
        modifier(active: RotateViewModifier(rotation: 180), identity: RotateViewModifier(rotation: 0))
    }
    static func rotating(rotation: Double) -> AnyTransition {
        return AnyTransition.modifier(active: RotateViewModifier(rotation: rotation), identity: RotateViewModifier(rotation: 0))
    }
    static var rotateOn: AnyTransition {
        return AnyTransition.asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading))
    }
}

struct AnyTransitionExamp: View {
    // MARK: - Properties
    @State private var showRect = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            if showRect {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 250, height: 350)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .transition(.move(edge: .leading))
//                .transition(AnyTransition.scale.animation(.easeInOut))
//                .transition(.rotating(rotation: 360))
                .transition(.rotateOn)
                
            }
            Spacer()
            Text("Click Me!")
                .withDefaultButtonFormatting()
                .padding(.horizontal, 40)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 2)) {
                        showRect.toggle()
                    }
                }
        } //: VStack
    }
}

struct AnyTransitionExamp_Previews: PreviewProvider {
    static var previews: some View {
        AnyTransitionExamp()
    }
}

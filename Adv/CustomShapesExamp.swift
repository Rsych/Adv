//
//  CustomShapesExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/02/18.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midX))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
        }
    }
    
    
}

struct CustomShapesExamp: View {
    var body: some View {
        ZStack {

//            Image("putin")
//                .resizable()
//                .scaledToFill()
            Trapezoid()
                .frame(width: 300, height: 100)
//                Diamond()
//            Triangle()
//                .stroke(style: .init(lineWidth: 3, lineCap: .round, dash: [50], dashPhase: 0))
//                .trim(from: 0, to: 0.5)
//                .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
//                .frame(width: 300, height: 300)
//                .clipShape(Triangle().rotation(Angle(degrees: 180)))
        }
    }
}

struct CustomShapesExamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapesExamp()
    }
}

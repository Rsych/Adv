//
//  ProtocolExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/17.
//

import SwiftUI

struct DefaultColorTheme {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColorTheme {
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

struct ProtocolExamp: View {
//    let colorTheme: DefaultColorTheme = DefaultColorTheme()
    let colorTheme: AlternativeColorTheme = AlternativeColorTheme()
    
    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            
            Text("Protocols")
                .font(.headline)
                .foregroundColor(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
        }
    }
}

struct ProtocolExamp_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolExamp()
    }
}

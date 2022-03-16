//
//  GeometryPreferenceKeyExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/16.
//

import SwiftUI

struct GeometryPreferenceKeyExamp: View {
    @State private var rectSize: CGSize = .zero
    var body: some View {
        VStack {
            Text("Hello")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(Color.blue)
            Spacer()
            HStack {
                Rectangle()
                GeometryReader { geo in
                    Rectangle()
                        .updateRectGeoSize(geo.size)
                        .overlay(
                            Text("\(geo.size.width)").foregroundColor(.white)
                        )
                }
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometrySizePreferenceKey.self) { value in
            self.rectSize = value
        }
    }
}

struct GeometryPreferenceKeyExamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKeyExamp()
    }
}

struct RectangleGeometrySizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension View {
    func updateRectGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
    }
}

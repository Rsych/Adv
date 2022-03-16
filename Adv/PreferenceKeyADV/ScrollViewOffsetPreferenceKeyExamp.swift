//
//  ScrollViewOffsetPreferenceKey.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/16.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    
    func onScrollViewOffsetChanged(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: { value in
                action(value)
            })
    }
}

struct ScrollViewOffsetPreferenceKeyExamp: View {
    let title: String = "New Title here"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset / 63.0))
                    .onScrollViewOffsetChanged { value in
                        self.scrollViewOffset = value
                    }
                contentLayer
            }
            .padding()
        }
        .overlay(Text("\(scrollViewOffset)"))
        
        .overlay(navBarLayer.opacity(scrollViewOffset < 40 ? 1.0 : 0.0), alignment: .top)
    }
}

extension ScrollViewOffsetPreferenceKeyExamp {
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var contentLayer: some View {
        ForEach(0..<30) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
    }
}

struct ScrollViewOffsetPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferenceKeyExamp()
    }
}

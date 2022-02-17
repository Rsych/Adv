//
//  MatchedGeometryEffectExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/02/17.
//

import SwiftUI

struct MatchedGeometryEffectExamp: View {
    @State private var isClicked = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
            }
            
            
            Spacer()
            if isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
            }
        } //: VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

struct MatchedGeometryEffectExamp_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectExamp2()
    }
}

struct MatchedGeometryEffectExamp2: View {
    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected: String = ""
    @Namespace private var namespace2
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack(alignment: .bottom) {
                    if selected == category {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.red)
                        .matchedGeometryEffect(id: "category_background", in: namespace2)
                        .frame(width: 35, height: 2)
                        .offset(y: 10)
                    }
                    
                    Text(category)
                        .foregroundColor(selected == category ? .red : .primary)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        }
        .padding()
    }
}

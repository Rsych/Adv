//
//  PreferenceKeyExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/16.
//

import SwiftUI

struct PreferenceKeyExamp: View {
    @State private var text = "Hello"
    var body: some View {
        NavigationView {
            VStack {
                SecondaryView(text: text)
                    .navigationTitle("Nav Title")
//                    .customTitle("New Value!!")
//                    .preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
            }
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
            self.text = value
        }
    }
}

extension View {
    func customTitle(_ text: String) -> some View {
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

struct PreferenceKeyExamp_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyExamp()
    }
}

struct SecondaryView: View {
    let text: String
    @State private var newValue: String = ""
    var body: some View {
        Text(text)
            .onAppear {
                getDataFromDatabase()
            }
            .customTitle(newValue)
//            .preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
    }
    func getDataFromDatabase() {
        // download
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "New value from Database"
        }
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

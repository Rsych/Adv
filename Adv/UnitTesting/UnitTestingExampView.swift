//
//  UnitTestingExampView.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/21.
//

/*
 1. Unit Tests
 - test the business logic in your app
 
 2. UI Tests
 - tests the UI of your app
 */

import SwiftUI

struct UnitTestingExampView: View {
    @StateObject private var vm: UnitTestingExampViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingExampViewModel(isPremium: isPremium))
    }
    var body: some View {
        Text(vm.isPremium.description)
    }
}

struct UnitTestingExampView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingExampView(isPremium: true)
    }
}

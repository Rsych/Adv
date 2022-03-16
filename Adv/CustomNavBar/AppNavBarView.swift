//
//  AppNavBarView.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/16.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink(destination:
                                Text("Destination")
                                .customNavTitle("Second Screen")
                                .customNavSubtitle("Subtitle is showing")
                ) {
                    Text("Navigate")
                }
            }
            .customNavBarItems(title: "New title", subtitle: "Subtitle", backButtonHidden: true)
        }
    }
}

extension AppNavBarView {
    private var defaultNavView: some View {
        NavigationView {
            ZStack {
                Color.gray.ignoresSafeArea()
                
                NavigationLink {
                    Text("Destination")
                        .navigationTitle("Title 2")
                        .navigationBarBackButtonHidden(false)
                } label: {
                    Text("Navigate")
                }
            } //: ZStack
            .navigationTitle("Nav title here")
        } //: NavView
    }
}

struct AppNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}

//
//  GenericsExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/16.
//

import SwiftUI

struct StringModel {
    let info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

struct GenericModel<T> {
    let info: T?
    
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    
    @Published var stringModel = StringModel(info: "Hello, world!")
    
    @Published var genericStringModel = GenericModel(info: "Hello, world!")
    @Published var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericView<T: View>: View {
    
    let content: T
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct GenericsExamp: View {
    @StateObject private var vm = GenericsViewModel()
    var body: some View {
        VStack {
            GenericView(content: Text("custom content"), title: "New View")
            
            Divider()
            
            Text(vm.stringModel.info ?? "No data")
            Text(vm.genericBoolModel.info?.description ?? "No data")
            Text(vm.genericStringModel.info ?? "No data")
                .onTapGesture {
                    vm.removeData()
                }
        }
    }
}

struct GenericsExamp_Previews: PreviewProvider {
    static var previews: some View {
        GenericsExamp()
    }
}

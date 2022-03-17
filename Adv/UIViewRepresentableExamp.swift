//
//  UIViewRepresentableExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/16.
//

import SwiftUI

// Convert a UIView from UIKit to SwiftUI
struct UIViewRepresentableExamp: View {
    @State private var text: String =  ""
    var body: some View {
        VStack {
            Text(text)
            HStack {
                Text("SwiftUI")
                TextField("Type here…", text: $text)
                    .frame(height: 55)
                .background(Color.green)
            }
            HStack {
                Text("UIKit")
                UITextFieldViewRepresentable(text: $text)
                    .updatePlaceholder("New placeholder")
                    .frame(height: 55)
                .background(Color.green)
            }
        }
    }
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeholder: String = "Default placeholder…", placeholderColor: UIColor = .red) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    // from SwiftUI to UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor : placeholderColor])
        textField.attributedPlaceholder = placeholder
        return textField
    }
    
    func updatePlaceholder(_ text: String) -> UITextFieldViewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    
    // from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

struct UIViewRepresentableExamp_Previews: PreviewProvider {
    static var previews: some View {
        UIViewRepresentableExamp()
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

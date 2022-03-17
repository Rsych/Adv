//
//  UIViewControllerRepresentableExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/17.
//

import SwiftUI

struct UIViewControllerRepresentableExamp: View {
    @State private var showModal: Bool = false
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack {
            Text("Hello")
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            Button {
                showModal.toggle()
            } label: {
                Text("Click Here")
            }
            .sheet(isPresented: $showModal) {
//                BasicUIViewControllerRepresentable(labelText: "New text here!")
                UIImagePickerControllerRepresentable(image: $image, showScreen: $showModal)
            }
        }
    }
}

struct UIViewControllerRepresentableExamp_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerRepresentableExamp()
    }
}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    // SwiftUI to UIKit
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showScreen: $showScreen)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding var showScreen: Bool
        
        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let newImage = info[.originalImage] as? UIImage else { return }
            image = newImage
            showScreen = false
        }
    }
}


struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    
    let labelText: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = FirstViewController()
        vc.labelText = labelText
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class FirstViewController: UIViewController {
    var labelText: String = "Start value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        let label = UILabel()
        label.text = labelText
        label.textColor = .white
        
        view.addSubview(label)
        label.frame = view.frame
    }
}

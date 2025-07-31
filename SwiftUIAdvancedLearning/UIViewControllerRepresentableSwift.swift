//
//  UIViewControllerRepresentableSwift.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 23/07/25.
//

import SwiftUI

struct UIViewControllerRepresentableSwift: View {
    
    @State private var image: UIImage? = nil
    @State private var showSheet: Bool = false
    
    var body: some View {
        VStack {
            Text("Pick Image")
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            
            Button {
                showSheet.toggle()
            } label: {
                Text("Select")
                    .withDefaultButtonStyle(color: .blue, font: .headline)
                    .padding()
            }
            
            .sheet(isPresented: $showSheet) {
                ImageUIViewControllerRepresentable(image: $image, showScreen: $showSheet)
            }
        }
    }
}

struct ImageUIViewControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
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
            guard let uiImage = info[.originalImage] as? UIImage else { return }
            image = uiImage
            showScreen = false
        }
    }
}

struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

#Preview {
    UIViewControllerRepresentableSwift()
}

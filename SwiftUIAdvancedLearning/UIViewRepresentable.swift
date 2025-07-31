//
//  UIViewRepresentable.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 23/07/25.
//

import SwiftUI

struct UIViewRepresentableDemo: View {
    @State private var text = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Text(text)
            TextField("Type here...", text: $text)
                .padding()
                .foregroundStyle(.white)
                .frame(height: 55)
                .background(Color.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            UITextFieldViewRepresentable(text: $text,placeHolder: "Typo", textColor: .white)
                .updatePlaceHolder("Type here...")
                .padding()
                .foregroundStyle(.white)
                .frame(height: 55)
                .background(Color.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .padding(.horizontal)
    }
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeHolder: String
    let textColor: UIColor
    
    init(text: Binding<String>, placeHolder: String = "Placeholder Text", textColor: UIColor = UIColor.red) {
        self._text = text
        self.placeHolder = placeHolder
        self.textColor = textColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField()
        let placeHolder = NSAttributedString(
            string: placeHolder,
            attributes: [.foregroundColor: textColor]
        )
        textField.attributedPlaceholder = placeHolder
        return textField
    }
    
    func updatePlaceHolder(_ text: String) ->  UITextFieldViewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeHolder = text
        return viewRepresentable
    }
    
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

#Preview {
    UIViewRepresentableDemo()
}

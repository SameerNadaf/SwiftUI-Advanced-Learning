//
//  UITestingDemoView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 26/07/25.
//

import SwiftUI

class UITestingDemoViewModel: ObservableObject {
    let placeholderText: String = "Enter username..."
    @Published var username: String = ""
    @Published var logInEnabled: Bool = false
    
    func buttonPressed() {
        guard !username.isEmpty else { return }
        logInEnabled.toggle()
    }
}

struct UITestingDemoView: View {
    
    @StateObject private var vm = UITestingDemoViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .blue],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            if vm.logInEnabled {
                WelcomeView()
                    .transition(AnyTransition.move(edge: .trailing))
            }
            else {
                firstScreen
                    .transition(AnyTransition.move(edge: .leading))
            }
        }
    }
}

extension UITestingDemoView {
    private var usernameTextField: some View {
        TextField(vm.placeholderText, text: $vm.username)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var textFieldButton: some View {
        Button {
            withAnimation(.spring()) {
                vm.buttonPressed()
            }
        } label: {
            Text("Sign In")
                .withDefaultButtonStyle(font: .headline)
        }
    }
    
    private var firstScreen: some View {
        VStack {
            usernameTextField
            textFieldButton
        }
        .padding()
    }
    
}

struct WelcomeView: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Show Alert")
                        .withDefaultButtonStyle(color: .red, font: .headline)
                }
                NavigationLink(destination: Text("Hello, buddies!")) {
                    Text("New Screen")
                        .withDefaultButtonStyle(color: .blue, font: .headline)
                }
                
                .alert(isPresented: $showAlert) {
                    return Alert(title: Text("Alert!!!!"), message: Text("Chill buddy its just a demo"), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}

#Preview {
    UITestingDemoView()
}

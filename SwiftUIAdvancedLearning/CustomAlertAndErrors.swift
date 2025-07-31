//
//  CustomAlertAndErrors.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 28/07/25.
//

import SwiftUI

protocol AppAlert {
    var title: String { get }
    var subTitle: String? { get }
    var buttons: AnyView { get }
}

extension View {
    func showAlert<T: AppAlert>(alert: Binding<T?>) -> some View {
        self.alert(alert.wrappedValue?.title ?? "Error", isPresented: Binding(value: alert)) {
            alert.wrappedValue?.buttons
        } message: {
            if let subTitle = alert.wrappedValue?.subTitle {
                Text(subTitle)
            }
        }

    }
}

struct CustomAlertAndErrors: View {
    
    @State private var showAlert = false
    @State private var myAlert: MyAlert?
    
    var body: some View {
        VStack {
            Button {
                downloadData()
            } label: {
                Text("Show Alert")
                    .withDefaultButtonStyle(color: .red, font: .title3)
            }
            .showAlert(alert: $myAlert)
        }
        .padding(.horizontal)
    }
}

extension CustomAlertAndErrors {
    
    enum MyAlert: Error, LocalizedError, AppAlert {
        case noInternetConnection
        case dataNotAvailable
        case invalidResponse
        
        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return "No Internet connection"
            case .dataNotAvailable:
                return "No data available"
            case .invalidResponse:
                return "Invalid response"
            }
        }
        
        var title: String {
            switch self {
            case .noInternetConnection:
                return "No Internet"
            case .dataNotAvailable:
                return "No data"
            case .invalidResponse:
                return "Invalid response"
            }
        }
        
        var subTitle: String? {
            switch self {
            case .noInternetConnection:
                return "Please check your internet connection."
            case .dataNotAvailable:
                return nil
            case .invalidResponse:
                return "Something went wrong. Please try again later."
            }
        }
        
        @ViewBuilder var button: some View {
            switch self {
            case .noInternetConnection:
                Button("OK") { }
                Button("RETRY") { }
            case .dataNotAvailable:
                Button("OK") { }
                Button("RETRY") { }
            case .invalidResponse:
                Button("OK") { }
            }
        }
        
        var buttons: AnyView {
            AnyView(button)
        }
    }
    
    private func downloadData() {
        let successful: Bool = false
        
        if successful {
            // Do something
        }
        else {
            myAlert = .noInternetConnection
            showAlert = true
        }
    }
}

#Preview {
    CustomAlertAndErrors()
}

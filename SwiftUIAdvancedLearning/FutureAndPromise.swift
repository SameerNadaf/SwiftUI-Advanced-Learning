//
//  FutureAndPromise.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 27/07/25.
//

import SwiftUI
import Combine

class FutureAndPromiseViewModel: ObservableObject {
    @Published var text: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    let url = URL(string: "https://www.apple.com/")!
    
    init () {
        download()
    }
    
    private func download() {
        getFuturePublisher()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedValue in
                self?.text = returnedValue
            }
            .store(in: &cancellables)
        
//        getEscapingClosure { [weak self] value, error in
//            self?.text = value
//        }

    }
    
    private func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map { _ in
                return "Hello, It's Combine"
            }
            .eraseToAnyPublisher()
    }
    
    private func getEscapingClosure(completion: @escaping(_ value: String, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion("Hello, It's Escaping Closure", error)
        }
        .resume()
    }
    
    private func getFuturePublisher() -> Future<String, Error> {
        return Future { promise in
            self.getEscapingClosure { value, error in
                if let error {
                    promise(.failure(error))
                }
                else {
                    promise(.success(value))
                }
            }
        }
    }
    
}

struct FutureAndPromise: View {
    
    @StateObject private var vm = FutureAndPromiseViewModel()
    var body: some View {
        Text(vm.text)
    }
}

#Preview {
    FutureAndPromise()
}

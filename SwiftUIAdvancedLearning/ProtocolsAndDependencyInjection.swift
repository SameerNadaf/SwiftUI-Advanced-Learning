//
//  ProtocolsAndDependencyInjection.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 24/07/25.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    // Url data:
    /*
     {
         "userId": 1,
         "id": 1,
         "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
         "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
       },
     */
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostModel], Error>
}

class ProductionData: DataServiceProtocol {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockData: DataServiceProtocol {
    
    var posts: [PostModel] = []
    
    init(posts: [PostModel]?) {
        self.posts = posts ?? [
            PostModel(userId: 1, id: 1, title: "One", body: "One"),
            PostModel(userId: 2, id: 2, title: "Two", body: "Two"),
            PostModel(userId: 3, id: 3, title: "Three", body: "Three"),
            PostModel(userId: 4, id: 4, title: "Four", body: "Four")
        ]
    }
    
    func getData() -> AnyPublisher<[PostModel], any Error> {
        Just(posts)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
}

class PrDjViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    private var cancellables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    init (dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadData()
    }
    
    private func loadData() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedData in
                self?.posts = returnedData
            }
            .store(in: &cancellables)
    }
}

struct ProtocolsAndDependencyInjection: View {
    
    @StateObject var vm: PrDjViewModel
    
    init(dataService: DataServiceProtocol) {
        _vm = .init(wrappedValue: PrDjViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.posts) { post in
                    Text(post.title)
                        .padding()
                        .background(Color.red.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
    }
}

#Preview {
//    let dataService = ProductionData(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    
    let dataService: DataServiceProtocol = MockData(posts: [
        PostModel(userId: 123, id: 123, title: "title", body: "body")
    ])
    
    ProtocolsAndDependencyInjection(dataService: dataService)
}

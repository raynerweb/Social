//
//  UserViewModel.swift
//  Social
//
//  Created by rayner on 05/04/21.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    
    //BOV = Bateu o Olho e Viu
    private let kBaseURL = "https://jsonplaceholder.typicode.com"
    
    @Published
    private(set) var users = [User]() {
        didSet {
            loading = false
        }
    }
    
    @Published
    private(set) var loading = false
    
    private var anyCancellable: AnyCancellable?
    
    func fetchUsers() {
        anyCancellable?.cancel()
        
        if let url = URL(string: "\(kBaseURL)/users") {
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            loading = true
            anyCancellable = session.dataTaskPublisher(for: request)
                .tryMap( { (entity) -> Data in
                    let (data, resp) = entity
                    
                    guard let response = resp as? HTTPURLResponse,
                          response.statusCode >= 200 &&
                            response.statusCode < 300 else { throw URLError(.badServerResponse) }
                    return data
                })
                .decode(type: [User].self, decoder: JSONDecoder())
                .breakpointOnError()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: sinkError(_:)) {
                    self.users = $0;
                }
        }
    }
    
    func addUser(user: User){
        users.append(user)
    }
    
    func oldFetchUser() {
        
        let session = URLSession.shared
        
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/users") {
            let task = session.dataTask(with: url) {(data, response, error) in
                if let resp = response as? HTTPURLResponse, resp.statusCode >= 200, resp.statusCode < 300,
                    let json = data {
                        DispatchQueue.main.async {
                            self.users = try! JSONDecoder().decode([User].self, from: json)
                        }
                    }
            }
            task.resume()
            
        }

        let main = DispatchQueue.main // Thread principal,
        
        DispatchQueue.global(qos: .background) // Baixa prioridade de execucao
        DispatchQueue.global(qos: .userInitiated) // usuario iniciou um processo mas nao necessita do feedback
        DispatchQueue.global(qos: .userInteractive) // usuario iniciou um processo mas está aguardando o feedback do app
        DispatchQueue.global(qos: .utility) // Prioridade acima do background
        DispatchQueue.global(qos: .utility) // Prioridade acima do background
    }
}

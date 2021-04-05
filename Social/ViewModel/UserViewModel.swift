//
//  UserViewModel.swift
//  Social
//
//  Created by rayner on 05/04/21.
//

import Foundation


class UserViewModel: ObservableObject {
    
    @Published
    private(set) var users = [User]()
    
    func fetchUser() {
        
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

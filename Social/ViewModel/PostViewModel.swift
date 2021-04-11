//
//  PostViewModel.swift
//  Social
//
//  Created by rayner on 11/04/21.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    
    //BOV = Bateu o Olho e Viu
    private let kBaseURL = "https://jsonplaceholder.typicode.com"
       
    @Published
    private(set) var  listPost = [PostUser]()
    
    private var anyCancellable: AnyCancellable?
       
    func fetchPosts(user: User) {
        
        if let url = URL(string: "\(kBaseURL)/users/\(user.id)/posts") {
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            anyCancellable = session.dataTaskPublisher(for: request)
                .tryMap( { (entity) -> Data in
                    let (data, resp) = entity
                    
                    guard let response = resp as? HTTPURLResponse,
                          response.statusCode >= 200 &&
                            response.statusCode < 300 else { throw URLError(.badServerResponse) }
                    return data
                })
                .decode(type: [PostUser].self, decoder: JSONDecoder())
                .breakpointOnError()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: sinkError(_:)) {
                    self.listPost = $0;
                }
            
        }
    }
    
}

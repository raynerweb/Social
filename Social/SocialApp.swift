//
//  SocialApp.swift
//  Social
//
//  Created by rayner on 05/04/21.
//

import SwiftUI

@main
struct SocialApp: App {
    
    init() {
        let user = User(id: 1, name: "rayner", username: "rayner.lima", email: "rayner.lima@gmail.com")
        //let json = JSONEncoder().encode(user)
//        do {
//            let json = try JSONEncoder().encode(user)
//
//        } catch (let error) {
//            print(error)
//        }
        
        if let json = try? JSONEncoder().encode(user) {
            let jsonString = String(data: json, encoding: .utf8)
//            print(jsonString)
            
            do {
                let sameUser = try JSONDecoder().decode(User.self, from: json)
//                print(sameUser)
            } catch (let error) {
//                print (error)
            }
            
        }
        
        
    }
    var body: some Scene {
        WindowGroup {
//            AddUserView(viewModel: UserViewModel())
            ContentView(viewModel: UserViewModel())
        }
    }
}

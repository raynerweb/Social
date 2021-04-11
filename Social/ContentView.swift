//
//  ContentView.swift
//  Social
//
//  Created by rayner on 05/04/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject
    var viewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            Group{
                if viewModel.loading {
                    VStack {
                        ProgressView()
                        Text("Aguarde! Carregando..")
                    }
                } else {
                    List {
                        ForEach(viewModel.users) { user in
                            NavigationLink(destination: PostView(user: user)) {
                                VStack {
                                    Text(user.name)
                                }
                            }
                        }
                    }
                }
                
                
            }
            .navigationTitle("Usuários")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddUserView(viewModel: viewModel)) {
                        Image(systemName: "Contacts")
                            .resizable()
                            .padding(6)
                            .frame(width: 24, height: 24)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                }
            }
//            .navigationBarItems(trailing:
//                                    NavigationLink(destination: AddUserView(viewModel: viewModel)) {
//                                        Text("Add User")
//                                    }
//            )
            .environmentObject(PostViewModel())
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: UserViewModel())
    }
}

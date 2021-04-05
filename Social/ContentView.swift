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
        List {
            ForEach(viewModel.users) { user in
                VStack {
                    Text(user.name)
                }
            }
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: UserViewModel())
    }
}

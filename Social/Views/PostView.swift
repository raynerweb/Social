//
//  PostView.swift
//  Social
//
//  Created by rayner on 11/04/21.
//

import SwiftUI

struct PostView: View {
    
    let user: User
    
    @EnvironmentObject
    var viewModel: PostViewModel
    
    var body: some View {
        Group {
            List{
                ForEach(viewModel.listPost) { postUser in
                    Text(postUser.title)
                }
            }
        }.onAppear {
            viewModel.fetchPosts(user: user)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(user: User(id: 0, name: "asd", username: "asd", email: "asd"))
    }
}

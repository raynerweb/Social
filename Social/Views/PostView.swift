//
//  PostView.swift
//  Social
//
//  Created by rayner on 11/04/21.
//

import SwiftUI

struct PostView: View {
    
    let user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(user: User(id: 0, name: "asd", username: "asd", email: "asd"))
    }
}

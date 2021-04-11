//
//  AddUserView.swift
//  Social
//
//  Created by rayner on 11/04/21.
//

import SwiftUI

struct AddUserView: View {
    
    @ObservedObject
    var viewModel: UserViewModel
    
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 6){
                Text("Name")
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            VStack(alignment: .leading, spacing: 6){
                Text("Username")
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            VStack(alignment: .leading, spacing: 6){
                Text("Email")
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Spacer()
            Button("Add User") {
                let user = User(id: 0, name: name, username: username, email: email)
                viewModel.addUser(user: user)
                self.mode.wrappedValue.dismiss()
            }
        }.padding()
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView(viewModel: UserViewModel())
    }
}

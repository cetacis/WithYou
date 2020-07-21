//
//  view_message.swift
//  WithYou
//
//  Created by una on 2020/7/12.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI


struct StreetRow: View {
    @State var index:Int
    @State var showingMessage: Bool = false
    @State var message: Message
    var body: some View {
        
        HStack {
            
            Image(systemName: message.IsUser ? "icloud.and.arrow.up" : "icloud.and.arrow.down")
                
                .resizable()
                .frame(width: 30, height: 30)
                .scaledToFit()
                .clipShape(Circle())
                .padding(.horizontal,15)
            
            Text(message.IsUser ? "From you" : "From admin")
            Spacer()
            Text(message.IsRead || message.IsUser ? "" : "Not Readed")
        }.onTapGesture {
            self.showingMessage = true
            User.Messages[index].IsRead = true
            PostChangeProfile(completion: { (code, msg) in
                print(code, msg)
            }, UserData: User)
            print("sheet")}
        .sheet(isPresented:self.$showingMessage) {
            MessageviewDetail(message: self.$message)
        }
    }
}


struct Messageview: View {
    @State var showingMessage = false
    @State var message = Message(msg: "", IsUser: false, IsRead: false)
    
    @State var messages = User.Messages
    init() {
        UITableView
            .appearance()
            .separatorStyle = .none
    }
    
    var body: some View {
        
        VStack {
            HStack{
                NavigationLink(destination: NewMessage(newMessages: self.$messages)) {
                    HStack {
                        Image(systemName: "pencil.and.outline")
                            .font(.headline)
                        Text("New Message")
                            .fontWeight(.semibold)
                            .font(.headline)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 255/255, green: 193/255, blue: 37/255))
                    .cornerRadius(10)
                }
                
                Button(action: {
                    self.messages = []
                    User.Messages = self.messages
                    PostChangeProfile(completion: {_,_ in }, UserData: User)
                    
                }) {
                    HStack {
                        Image(systemName: "xmark.icloud")
                            .font(.headline)
                        Text("Clear All")
                            .fontWeight(.semibold)
                            .font(.headline)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 255/255, green: 193/255, blue: 37/255))
                    .cornerRadius(10)
                }
            }.padding(EdgeInsets(top:10, leading: 0, bottom: 2, trailing: 0))
            
            List {
                
                ForEach(0..<self.messages.count, id: \.self){
                    index in
                    StreetRow(index: index, message: self.messages[index])
                    
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 15))
                .background(Color(red:0.85,green:0.85,blue:0.95))
                .cornerRadius(10)
                
            }.padding(EdgeInsets(top: 2, leading: 15, bottom: 2, trailing: 15))
            
            
        }
    }
    
    
}

struct view_message_Previews: PreviewProvider {
    static var previews: some View {
        Messageview()
    }
}

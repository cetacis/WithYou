//
//  view_message.swift
//  WithYou
//
//  Created by una on 2020/7/12.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

struct Street: Identifiable {
    var id = UUID()
    var index:Int
    @State var showingMessage: Bool
    @State var message: Message
}

struct StreetRow: View {
    var street: Street
    var body: some View {
        
        HStack {
               
        Image(systemName: User.Messages[self.street.index].IsUser ? "icloud.and.arrow.up" : "icloud.and.arrow.down")
               
                   .resizable()
                   .frame(width: 30, height: 30)
                   .scaledToFit()
                   .clipShape(Circle())
       
                   .padding(.horizontal,15)
                   .onTapGesture {
                    self.street.showingMessage.toggle()
                    self.street.message = User.Messages[self.street.index]
                    print("sheet")
               }.sheet(isPresented:self.street.$showingMessage) {
                MessageviewDetail(message: self.street.$message)
               }
        Text(User.Messages[self.street.index].IsUser ? "From you" : "From admin")
               Spacer()
               Text(User.Messages[self.street.index].IsRead || User.Messages[self.street.index].IsUser ? "" : "Not Readed")
           }
    }
}


struct Messageview: View {
    @State var showingMessage = false
    @State var message = Message(msg: "", IsUser: false, IsRead: false)
    @State var messages = User.Messages
    init(){UITableView.appearance().separatorStyle = .none}
    var body: some View {
        
        VStack {
            HStack{
                          NavigationLink(destination: NewMessage()) {
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
                    
                    StreetRow(street: Street(index: index, showingMessage: self.showingMessage, message: self.message))
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

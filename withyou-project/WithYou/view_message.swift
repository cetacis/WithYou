//
//  view_message.swift
//  WithYou
//
//  Created by una on 2020/7/12.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

struct Messageview: View {
    @State var showingMessage = false
    @State var message = Message(msg: "", IsUser: false, IsRead: false)
    var body: some View {
        
        VStack {
         
            VStack {
           
                ForEach(0..<User.Messages.count, id: \.self){
                    index in
                    HStack {
                        
                        Image(systemName: User.Messages[index].IsUser ? "icloud.and.arrow.up" : "icloud.and.arrow.down")
                        
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .clipShape(Circle())
                
                            .padding(.horizontal,15)
                            .onTapGesture {
                                self.showingMessage.toggle()
                                self.message = User.Messages[index]
                        }.sheet(isPresented: self.$showingMessage) {
                            MessageviewDetail(message: self.$message)
                        }
                        Text(User.Messages[index].IsUser ? "From you" : "From admin")
                        Spacer()
                        Text(User.Messages[index].IsRead || User.Messages[index].IsUser ? "" : "Not Readed")
                    }
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 15))
                    .background(Color(red:0.85,green:0.85,blue:0.95))
                .cornerRadius(10)
            }.padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                .offset(y:-270)
            HStack{
               NavigationLink(destination: Messageview()) {
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
                } .offset(y:300)
                
            Button(action: {
                User.Messages = []

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
                               
                                  
                              } .offset(y:300)
            }
        }
    }
    
    
}

struct view_message_Previews: PreviewProvider {
    static var previews: some View {
        Messageview()
    }
}

//
//  view_message_newmsg.swift
//  WithYou
//
//  Created by una on 2020/7/13.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

struct NewMessage: View {
    
    @State var showmoreprofile = false
    @State var text:String = "  Type here: Your advice is important to our improvement."
    @State var updatesuccess:Bool = false
    @State var updatefail:Bool = false
    @State var updatefailalert:String = ""
    @State var showAlert:Bool = false
    @State var currentDate = "\n\n\n\n\n time: \(Date())"
    @Binding var newMessages : [Message]
    var body: some View {
        VStack{
            VStack {
                Text("New Message").font(.system(size: 30)).foregroundColor(Color.gray).multilineTextAlignment(.center).lineLimit(nil).padding(.top,8)
                TextView(
                    text: $text
                )
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                
            }.frame(height:500)
                .background(Color(red: 235/255, green: 235/255, blue: 255/255))
                .cornerRadius(8)
                .padding()
                .offset(y:-80)
                .overlay(
                    HStack{
                        
                        Button(action: {
                            self.newMessages.append(Message(msg: self.text+self.currentDate, IsUser: true, IsRead: true))
                            User.Messages = self.newMessages
                            PostChangeProfile(completion: { (code, msg) in
                                if code == 0{
                                    print("After append the  new Messages:")
                                    print(User.Messages)
                                    self.showAlert = true
                                    self.updatesuccess = true
                                }else{
                                    
                                    self.showAlert = true
                                    self.updatefailalert = msg
                                    self.updatefail = true
                                }
                            
                            }, UserData: User)
                            }) {
                            HStack {
                                Image(systemName: "pencil.and.outline")
                                    .font(.headline)
                                Text("Submit")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 255/255, green: 193/255, blue: 37/255))
                            .cornerRadius(10)
                        } .offset(y:230)
                            .alert(isPresented: self.$showAlert) {
                            Alert(title: Text(self.updatesuccess ? "Send successfully, we have receive your feedback and we will deal with them immediately." : self.updatefailalert), dismissButton: .default(Text("OK")))
                        }
                          
                        
                        Button(action: {
                            self.text = ""
                        }) {
                            HStack {
                                Image(systemName: "xmark.icloud")
                                    .font(.headline)
                                Text("Clear")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 255/255, green: 193/255, blue: 37/255))
                            .cornerRadius(10)
                        } .offset(y:230)
                    }
            )
        }
        
    }
}


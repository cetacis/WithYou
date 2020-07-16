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
                            print(User.Messages)
                            User.Messages.append(Message(msg: self.text, IsUser: true, IsRead: true))
                            print(User.Messages)
                          
                            PostChangeProfile(completion: { (code, msg) in
                                print("#1")
                                if code == 0{
                                    print("send suc")
                                    self.updatesuccess = true
                                }else{
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
                        } .offset(y:230).alert(isPresented: self.$updatesuccess) {
                            Alert(title: Text("Send successfully, we have receive your feedback and we will deal with them immediately."), dismissButton: .default(Text("OK")))
                        }.alert(isPresented: self.$updatefail) {
                            Alert(title: Text(self.updatefailalert), dismissButton: .default(Text("OK")))
                        }
                          
                        
                        Button(action: {
                            User.Messages = [] // clear up the messages
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


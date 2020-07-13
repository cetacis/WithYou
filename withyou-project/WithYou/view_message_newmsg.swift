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
                        
                        Button(action: {
                            //todo:post清空message
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

struct view_message_newmeg_Previews: PreviewProvider {
    @State var showMessage:Bool = false
    @State var message:Message = Message(msg: "", IsUser: false, IsRead: false)
    static var previews: some View {
        NewMessage()
    }
}

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
   @State var Friend: PersonInfo = PersonInfo()
    var body: some View {
        
        VStack {
            Text("YouFriend")
                .font(.title)
            List {
                ForEach(0..<User.Friends.count, id: \.self){
                    index in
                    HStack {
                        Image("player2")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.gray, lineWidth: 2))
                            .padding(.horizontal,15)
                            .onTapGesture {
                                let users = realm.objects(PersonInfo.self).filter("email = '\(User.Friends[index])'")
                                self.Friend = users[0]
                                self.showingMessage.toggle()
                        }.sheet(isPresented: self.$showingMessage) {
                            Friendprofileview(showingprofile: self.$showingMessage, User: self.Friend)
                        }
                        Text(User.Friends[index])
                    }
                }
            }
        }
    }
    
    
}

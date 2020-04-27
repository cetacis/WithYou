//
//  Friends.swift
//  WithYou
//
//  Created by kelo on 2020/4/17.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

struct FriendView:View {
    @State var showingprofile = false
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
                                self.showingprofile.toggle()
                        }.sheet(isPresented: self.$showingprofile) {
                            Friendprofileview(showingprofile: self.$showingprofile, User: self.Friend)
                        }
                        Text(User.Friends[index])
                    }
                }
            }
        }
    }
}

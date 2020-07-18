//
//  Friends.swift
//  WithYou
//
//  Created by kelo on 2020/4/17.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

func GetFriend (index:Int){
    
    GetFriendInfo(completion: {(RtData) in
        
        temFriend = RtData
        
    }, email: User.partner)
    
}
struct FriendView:View {
    @State var showingprofile = false
    @State var Friend: UserInfo = UserInfo()
    var body: some View {
        VStack {
            Group{
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
                                    // To do: get the friend by the Friends[index](email)
                                    //post email=friend.email
                                    // api/getfriend
                                    let friend = UserInfo()
                                    self.Friend = friend
                                    self.showingprofile.toggle()
                            }.sheet(isPresented: self.$showingprofile) {
                                
                                Friendprofileview(showingprofile: self.$showingprofile, User: self.Friend)
                            }
                            Text(User.Friends[index])
                        }.onAppear(perform: {
                            
                            GetFriendInfo(completion: {(RtData) in
                                
                                temFriend = RtData
                                
                            }, email: User.Friends[index])
                            
                        })
                    }
                    
                    
                }
                
            }
        }
    }
}

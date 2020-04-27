//
//  FriendProfile.swift
//  WithYou
//
//  Created by kelo on 2020/4/17.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation

import Foundation
import SwiftUI

struct Friendprofileview: View {
    @Binding var showingprofile: Bool
    @State var showmoreprofile = false
    @State var User: PersonInfo
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        self.showingprofile.toggle()
                    }) {
                        Text("Done")
                    }
                }.frame(width: 365).padding(.top,10)
                Divider()
                VStack {
                    Choose
                        .resizable()
                        .frame(width: 80, height: 80)
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.gray, lineWidth: 2))
                        .padding(.horizontal,15)
                    Text(User.username)
                        .font(.title)
                    Text(User.bio)
                        .font(.headline)
                }
                Divider()
                VStack {
                    VStack{
                        HStack {
                            Text("Moblie")
                            Spacer()
                        }
                        HStack {
                            Text(User.mobile)
                                .font(.headline)
                            Spacer()
                        }
                    }.frame(width: 365)
                    Divider()
                    VStack{
                        HStack {
                            Text("Mail")
                            Spacer()
                        }
                        HStack {
                            Text(User.email)
                                .font(.headline)
                            Spacer()
                        }
                    }.frame(width: 365)
                    Divider()
                    VStack{
                        HStack {
                            Text("Age")
                            Spacer()
                        }
                        HStack {
                            Text(User.age)
                                .font(.headline)
                            Spacer()
                        }
                    }.frame(width: 365)
                    Divider()
                    VStack{
                        HStack {
                            Text("Sex")
                            Spacer()
                        }
                        HStack {
                            Text(User.sex)
                                .font(.headline)
                            Spacer()
                        }
                    }.frame(width: 365)
                    VStack{
                        Divider()
                        NavigationLink(destination: MoreProfile().onAppear() {
                            self.showmoreprofile = false
                        }) {
                            HStack {
                                Text("More Profile")
                                    .font(.headline)
                                Spacer()
                            }.frame(width:365)
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitle(Text("profile"),displayMode: .inline)
            .navigationBarHidden(self.showmoreprofile)
            .onAppear() {
                self.showmoreprofile = true
            }
        }
    }
}

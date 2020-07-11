//
//  Home.swift
//  WithYou
//
//  Created by kelo on 2020/4/14.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

class UserSettings: ObservableObject {
    @Published var count = 0
}

class timer: ObservableObject {
    @Published var time = 0
}

struct HomeView_together: View {
    @Environment(\.imageCache) var cache: ImageCache
    @State var showingaddtask = false
    @State var showingprofile = false
    @State var showingnavi = false
    @State var timing: timer = timer()
    @Binding var view_swither: Int
    @ObservedObject var settings = UserSettings()
    
    let Clock = Timer.publish(every: 5, on: .current, in: .common).autoconnect()
    var body: some View {
      NavigationView {
            VStack {
                HStack {
                    Text("withYou")
                        .font(.system(size:40, design: .rounded))
                        .foregroundColor(.blue)
                        .offset(y: 5)
                    Spacer()
                        AsyncImage(
                            url: URL(string: "https://img.cetacis.dev/uploads/big/eb1dc98270f647c1e236ecb56b51a98a.jpg")!,
                            cache: self.cache,
                            placeholder: Text("laoding"),
                            configuration: {
                                $0.resizable()
                            }
                        ).frame(width: 50, height: 50)
                            .scaledToFit()
                            .offset(y: 5)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.gray, lineWidth: 2))
                            .padding(.horizontal,15)
                            .onTapGesture {
                                self.showingprofile.toggle()
                        }.sheet(isPresented: self.$showingprofile) {
                            profileview(showingprofile: self.$showingprofile)
                        }
                }.frame(width: 380)
                Divider()
                HStack {
                    Text("Together Schedule")
                        .font(.title)
                        .foregroundColor(.blue)
                    Spacer()
                }.frame(width:380).padding(.top,20)
                HStack {
                    VStack{
                        Text("Your")
                            .font(.subheadline)
                        List {
                            ForEach(0..<Array(User.togethertasks).count, id: \.self) {
                                index in NavigationLink(destination: TagContent(TagName: User.togethertasks[index].Name, isFriend: false, taskid: index).onAppear(){
                                    self.showingnavi = false
                                }) {
                                    if (!User.togethertasks[index].isFinished) {
                                        Text(User.togethertasks[index].Name)
                                    } else {
                                        Text(User.togethertasks[index].Name).foregroundColor(Color.gray).strikethrough()
                                    }
                                }
                            }
                        }
                        .colorMultiply(Color(red:0.85,green:0.85,blue:0.95))
                        .cornerRadius(10)
                      
                    }
                    Divider()
                    VStack {
                        Text("Friends")
                            .font(.subheadline)
                        List {
                            ForEach(0..<Array(User.togethertasks).count, id: \.self) {
                                index in NavigationLink(destination: TagContent(TagName: User.togethertasks[index].Name, isFriend: true, taskid: index).onAppear(){
                                    self.showingnavi = false
                                }) {
                                    Text(User.togethertasks[index].Name)
                                }
                            }
                        }
                        .colorMultiply(Color(red:0.85,green:0.85,blue:0.95))
                        .cornerRadius(10)
                    }
                }
                .frame(width: 380)
                HStack {
                    NavigationLink(destination: FriendView().onAppear() {
                        self.showingnavi = false
                    }) {
                        HStack {
                            Image(systemName: "person.circle")
                                .font(.headline)
                            Text("Your Friend")
                                .fontWeight(.semibold)
                                .font(.headline)
                            
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.yellow)
                        .cornerRadius(10)
                    }
                    Spacer()
                    Button(action: {
                        self.view_swither = 3
                    }) {
                        HStack {
                            Image(systemName: "pencil.and.outline")
                                .font(.headline)
                            Text("Together Schedule")
                                .fontWeight(.semibold)
                                .font(.headline)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 255/255, green: 193/255, blue: 37/255))
                        .cornerRadius(10)
                    }
                }.frame(width:380)
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        self.showingaddtask.toggle()
                    }) {
                        Text("Add Tasks")
                    }.sheet(isPresented: $showingaddtask) {
                        addNewTask(showingaddtask: self.$showingaddtask)
                        
                    }
                }.frame(width:300)
            }
            .navigationBarTitle(Text("Home"),displayMode: .inline)
            .navigationBarHidden(showingnavi)
            .onAppear() {
                self.showingnavi = true
            }
            }
        }
    
}


struct HomeView_person: View {
    @State var showingaddtask = false
    @State var showingprofile = false
    @State var showingnavi = false
    @Binding var view_swither: Int
    @State var IsChanging = false
    @State var taskcontent = ""
    @ObservedObject var settings = UserSettings()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("withYou")
                        .font(.system(size:40, design: .rounded))
                        .foregroundColor(.blue)
                        .offset(y: 5)
                    Spacer()
                    Choose
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaledToFit()
                        .offset(y: 5)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.gray, lineWidth: 2))
                        .padding(.horizontal,15)
                        .onTapGesture {
                            self.showingprofile.toggle()
                    }.sheet(isPresented: $showingprofile) {
                        profileview(showingprofile: self.$showingprofile)
                    }
                }.frame(width: 380)
                Divider()
                HStack {
                    Text("Your Tasks")
                        .font(.title)
                        .foregroundColor(.blue)
                    Spacer()
                }.frame(width:380).padding(.top,20)
                List {
                    ForEach(User.privatetasks, id: \.self) {
                        message in
                        HStack {
                            if message.number == 0 {
                                Text("\(message.Name)")
                                Spacer()
                                Image(systemName: "circle")
                                    .onTapGesture {
                                        try! realm.write {
                                            message.number = 1
                                            self.settings.count += 1
                                        }
                                }
                            }
                            if message.number == 1 {
                                Text("\(message.Name)").foregroundColor(Color.gray).strikethrough()
                                Spacer()
                                Image(systemName: "checkmark.circle")
                                    .onTapGesture {
                                        try! realm.write {
                                            message.number = 0
                                            self.settings.count -= 1
                                        }
                                }
                            }
                        }
                    }
                }
             
                .colorMultiply(Color(red:0.85,green:0.85,blue:0.95))
                .cornerRadius(10)
                .frame(width: 380)
     
                HStack {
                    NavigationLink(destination: FriendView().onAppear() {
                        self.showingnavi = false
                    }) {
                        HStack {
                            Image(systemName: "person.circle")
                                .font(.headline)
                            Text("Your Friend")
                                .fontWeight(.semibold)
                                .font(.headline)
                            
                            
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(.orange))
                        .cornerRadius(10)
                    }
                    Spacer()
                    Button(action: {
                        self.view_swither = 2
                    }) {
                        HStack {
                            Image(systemName: "pencil.and.outline")
                                .font(.headline)
                            Text("private tasktask")
                                .fontWeight(.semibold)
                                .font(.headline)
                            
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(.orange))
                        .cornerRadius(10)
                    }
                }.frame(width:380)
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        self.showingaddtask.toggle()
                    }) {
                        Text("Add Tasks")
                    }.sheet(isPresented: $showingaddtask) {
                        addNewPrivateTask(addingtask: self.$showingaddtask, IsChanging: self.$IsChanging)
                    }
                    if IsChanging {
                        Text("")
                    }
                }.frame(width:300)
            }
            .navigationBarTitle(Text("Home"),displayMode: .inline)
            .navigationBarHidden(showingnavi)
            .onAppear() {
                self.showingnavi = true
            }
        }
    }
}

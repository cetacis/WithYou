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

func checkNewMessage() -> Bool {
    var hasNewMessage = false
    for i in 0..<User.Messages.count {
        
        if (User.Messages[i].IsRead == true){hasNewMessage = true}
        hasNewMessage = false
        break
    }
    return hasNewMessage
}



struct HomeView_together: View {
    @State var showingaddtask = false
    @State var showingprofile = false
    @State var showingnavi = false
    @State var showingmessage = false
    
    @Binding var view_swither: Int
    
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Image?
    private let configuration: (Image) -> Image
    private let url: URL
    private let cache: ImageCache?
    init(url: URL, cache: ImageCache? = nil, view_swither: Binding<Int>) {
        loader = ImageLoader(url: url, cache: cache)
        self.placeholder = Choose
        self.configuration = {$0.resizable()}
        self._view_swither = view_swither
        self.url = url
        self.cache = cache
    }
    
    private var image: some View {
        Group {
            if loader.image != nil  {
                configuration(Image(uiImage: loader.image!))
            } else {
                placeholder
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("withYou")
                        .font(.system(size:40, design: .rounded))
                        .foregroundColor(.blue)
                        .offset(y: 5)
                    Spacer()
                    // message button
                    NavigationLink(destination: Messageview().onAppear() {
                        self.showingnavi = false
                    }) {
                        HStack {
                            Image(systemName: "message.fill")
                                .font(.headline)
                        }
                        .foregroundColor(.blue)
                        .background(Color(red: 1, green: 1, blue: 1))
                        .overlay(checkNewMessage() ? Color.red.frame(width: 16, height: 16) .cornerRadius(8) .offset(x: 23, y: -23) : Color.red.frame(width: 16, height: 16) .cornerRadius(8) .offset(x: 23, y: -200))
                    }
                    
                    image
                        .onAppear(perform: loader.load)
                        .onDisappear(perform: loader.cancel).frame(width: 50, height: 50)
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.gray, lineWidth: 2))
                        .padding(.horizontal,15)
                        .onTapGesture {
                            self.showingprofile = true
                    }.sheet(isPresented: self.$showingprofile) {
                        profileview(url: self.url, cache: self.cache, showingprofile: self.$showingprofile)
                    }
                }.frame(width: 380)
                Divider()
                HStack {
                    Text("Together Schedule")
                        .font(.headline)
                        .foregroundColor(.blue)

                }.frame(width:380)
                HStack {
                    VStack{
                        Text("Your")
                            .font(.subheadline)
                        List {
                            ForEach(0..<User.TogetherTasks.count, id: \.self){
                                index in
                                NavigationLink(destination: TagContent(TagName: User.TogetherTasks[index].name, isFriend: false, taskid: index).onAppear(){
                                    self.showingnavi = false
                                }) {
                                    if (!User.TogetherTasks[index].IsFinished) {
                                        Text(User.TogetherTasks[index].name)
                                    } else {
                                        Text(User.TogetherTasks[index].name).foregroundColor(Color.gray).strikethrough()
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
                        List {//0..<User.Friends.count, id: \.self
                            ForEach(0..<Partner.TogetherTasks.count, id: \.self){
                                index in
                                NavigationLink(destination: TagContent(TagName: Partner.TogetherTasks[index].name, isFriend: true, taskid: index).onAppear(){
                                    self.showingnavi = false
                                }) {
                                    if (!Partner.TogetherTasks[index].IsFinished) {
                                        Text(Partner.TogetherTasks[index].name)
                                    } else {
                                        Text(Partner.TogetherTasks[index].name).foregroundColor(Color.gray).strikethrough()
                                    }
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

/*

struct HomeView_person: View {
    @Environment(\.imageCache) var cache: ImageCache
    @State var showingaddtask = false
    @State var showingprofile = false
    @State var showingnavi = false
    @Binding var view_swither: Int
    @State var IsChanging = false
    @State var taskcontent = ""
    @ObservedObject var settings = UserSettings()
    
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Image?
    private let configuration: (Image) -> Image
    
    init(url: URL, cache: ImageCache? = nil, view_swither: Binding<Int>) {
        loader = ImageLoader(url: url, cache: cache)
        self.placeholder = Choose
        self.configuration = {$0.resizable()}
        self._view_swither = view_swither
    }
    
    private var image: some View {
        Group {
            if loader.image != nil  {
                configuration(Image(uiImage: loader.image!))
            } else {
                placeholder
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("withYou")
                        .font(.system(size:40, design: .rounded))
                        .foregroundColor(.blue)
                        .offset(y: 5)
                    Spacer()
                    
                    image
                        .onAppear(perform: loader.load)
                        .onDisappear(perform: loader.cancel).frame(width: 50, height: 50)
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
                    Text("Your Tasks")
                        .font(.title)
                        .foregroundColor(.blue)
                    Spacer()
                }.frame(width:380).padding(.top,20)
                List {
                    
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
                                Text("private Schedule")
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
}

*/

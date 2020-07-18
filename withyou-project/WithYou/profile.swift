//
//  profile.swift
//  WithYou
//
//  Created by kelo on 2020/4/15.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

struct profileview: View {
    @Binding var showingprofile: Bool
    @State var showmoreprofile = false
    
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Image?
    private let configuration: (Image) -> Image
    private let url: URL
    private let cache: ImageCache?
    init(url: URL, cache: ImageCache? = nil, showingprofile: Binding<Bool>) {
        loader = ImageLoader(url: url, cache: cache)
        self.placeholder = Choose
        self.configuration = {$0.resizable()}
        self.url = url
        self.cache = cache
        self._showingprofile = showingprofile
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
                    Spacer()
                    Button(action: {
                        self.showingprofile = false
                    }) {
                        Text("Done")
                    }
                }.frame(width: 365).padding(.top,10)
                Divider()
                VStack {
                    image
                        .onAppear(perform: loader.load)
                        .onDisappear(perform: loader.cancel).frame(width: 50, height: 50)
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
                        NavigationLink(destination: MoreProfile(url: self.url, cache: self.cache).onAppear() {
                            self.showmoreprofile = false
                        }) {
                            HStack {
                                Text("More Profile")
                                    .font(.headline)
                                Spacer()
                            }.frame(width:365)
                        }
                        Divider()
                        NavigationLink(destination: MoreProfile(url: self.url, cache: self.cache).onAppear() {
                            self.showmoreprofile = false
                        }) {
                            HStack {
                                Text("Change Profile")
                                    .font(.headline)
                                Spacer()
                            }.frame(width:365)
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitle(Text("profile"))
            .navigationBarHidden(self.showmoreprofile)
            .onAppear() {
                self.showmoreprofile = true
            }
        }
    }
}

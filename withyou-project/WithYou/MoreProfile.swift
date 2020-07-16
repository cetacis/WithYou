//
//  MoreProfile.swift
//  WithYou
//
//  Created by kelo on 2020/4/15.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

struct MoreProfile: View {
    
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Image?
    private let configuration: (Image) -> Image
    private let url: URL
    private let cache: ImageCache?
    init(url: URL, cache: ImageCache? = nil) {
        loader = ImageLoader(url: url, cache: cache)
        self.placeholder = Choose
        self.configuration = {$0.resizable()}
        self.url = url
        self.cache = cache
    }
    
    var image: some View {
        Group {
            if loader.image != nil  {
                configuration(Image(uiImage: loader.image!))
            } else {
                placeholder
            }
        }
    }
    
    var body: some View {
        VStack {
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
            VStack{
                HStack {
                    Text("Birth")
                    Spacer()
                }
                HStack {
                    Text(User.birthday)
                        .font(.headline)
                    Spacer()
                }
            }.frame(width: 365)
            Divider()
            VStack{
                HStack {
                    Text("Constellation")
                    Spacer()
                }
                HStack {
                    Text(User.constellation)
                        .font(.headline)
                    Spacer()
                }
            }.frame(width: 365)
            Divider()
            Spacer()
        }
    }
}

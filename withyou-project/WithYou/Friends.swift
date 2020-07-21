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
    @State var changed = 0
    @Environment(\.imageCache) var cache: ImageCache
    @State var loader: ImageLoader = ImageLoader(url: URL(string: "https://img.cetacis.dev/uploads/big/eb1dc98270f647c1e236ecb56b51a98a.jpg")!, cache: nil)
    private let placeholder = Choose
    private let configuration: (Image) -> Image = {
        $0.resizable()
    }
    
    func Loading(url: URL, cache: ImageCache? = nil) {
        loader = ImageLoader(url: url, cache: cache)
        loader.load()
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
        VStack {
            Group{
                Text("YouFriend")
                    .font(.title)
                List {
                    ForEach(0..<Friends.count, id: \.self){
                        index in
                        HStack {
                            ImgDict[Friends[index].email]
                            Spacer()
                            Text("\(Friends[index].email)")
                        }
                    }
                    
                    
                }
                
            }
        }
    }
}

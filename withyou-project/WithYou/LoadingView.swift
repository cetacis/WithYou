//
//  LoadingView.swift
//  WithYou
//
//  Created by 邓萌达 on 20/7/20.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingView: View {
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
        VStack {
            image
                .onAppear(perform: loader.load)
                .onDisappear(perform: loader.cancel).frame(width: 200, height: 200)
                .scaledToFit()
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.gray, lineWidth: 2))
                .padding(.horizontal,15)
                
            Text("loading..")
        }
    }
}

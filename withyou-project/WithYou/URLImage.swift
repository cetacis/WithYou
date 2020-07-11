//
//  URLImage.swift
//  WithYou
//
//  Created by 邓萌达 on 12/7/20.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

struct URLImage : View {

    init() {
        self.placeholder = Image(systemName: "photo")
        self.imageLoader = ImageLoader()
    }

    @ObservedObject var imageLoader: ImageLoader

    var placeholder: Image

    var body: some View {
        imageLoader.image == nil ?
            placeholder : Image(uiImage: imageLoader.image!)
    }
}

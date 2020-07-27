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
    var body: some View {
        VStack {
            UserPortrait
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.gray, lineWidth: 2))
                .padding(.horizontal,15)
                
            Text("loading..")
                .font(.system(size:30, design: .rounded))
                .foregroundColor(.orange)
        }
    }
}

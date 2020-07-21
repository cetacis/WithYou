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
    
    var body: some View {
        VStack {
            Group{
                Text("YouFriend")
                    .font(.title)
                List {
                    ForEach(0..<Friends.count, id: \.self){
                        index in
                        HStack {
                            ImgDict[Friends[index].email]!
                                .resizable()
                                .frame(width: 50, height: 50)
                                .scaledToFit()
                                .offset(y: 5)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.gray, lineWidth: 2))
                                .padding(.horizontal,15)
                            Spacer()
                            Text("\(Friends[index].email)")
                        }
                    }
                    
                    
                }
                
            }
        }
    }
}

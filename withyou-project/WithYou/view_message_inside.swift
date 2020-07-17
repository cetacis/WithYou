//
//  view_message_inside.swift
//  WithYou
//
//  Created by una on 2020/7/12.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

struct MessageviewDetail: View {
    @Binding var message:Message
    @State var showmoreprofile = false

    var body: some View {
       List {
        Text(self.message.IsUser ? "Your advice" : "New message").font(.system(size: 30)).foregroundColor(Color.gray).multilineTextAlignment(.center).lineLimit(nil).padding(.top,8)
        Divider()
        Text(self.message.msg)
                
                
        }.frame(height:500)
            .background(Color(red: 235/255, green: 235/255, blue: 255/255))
            .cornerRadius(8)
            .onAppear() {
            }
       .padding()
       .offset(y:-80)
        
    }
}


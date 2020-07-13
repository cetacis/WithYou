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

    @State var showmoreprofile = false
    @State var text:String = "  Type here: Your advice is important to our improvement."
    var body: some View {
       VStack {
            Text("New Message").font(.system(size: 30)).foregroundColor(Color.gray).multilineTextAlignment(.center).lineLimit(nil).padding(.top,8)
            TextView(
                text: $text
                )
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }.frame(height:500)
            .background(Color(red: 235/255, green: 235/255, blue: 255/255))
            .cornerRadius(8)
            .onAppear() {
            }
       .padding()
       .offset(y:-80)
        
    }
}

struct view_message_inside_Previews: PreviewProvider {
    @State var showMessage:Bool = false
    @State var message:Message = Message(msg: "", IsUser: false, IsRead: false)
    static var previews: some View {
        MessageviewDetail()
    }
}

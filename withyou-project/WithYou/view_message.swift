//
//  view_message.swift
//  WithYou
//
//  Created by una on 2020/7/12.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

struct Messageview: View {
    @State var showingMessage = false
    @State var message = Message()
    var body: some View {
        
        VStack {
            Text("YouFriend")
                .font(.title)
            List {
                ForEach(0..<User.Messages.count, id: \.self){
                    index in
                    HStack {
                        
                        Image(systemName: User.Messages[index].IsUser ? "icloud.and.arrow.up" : "icloud.and.arrow.down")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .scaledToFit()
                            .clipShape(Circle())
                
                            .padding(.horizontal,15)
                            .onTapGesture {
                                self.showingMessage.toggle()
                                self.message = User.Messages[index]
                        }.sheet(isPresented: self.$showingMessage) {
                            MessageviewDetail(showingMessage: self.$showingMessage, message:self.$message)
                        }
                        Text(User.Messages[index].IsUser ? "From you." : "From admin")
                    }
                }
            }
        }
    }
    
    
}

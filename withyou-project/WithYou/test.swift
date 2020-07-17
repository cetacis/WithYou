//
//  test.swift
//  WithYou
//
//  Created by una on 2020/7/17.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

struct SwiftUI: View {
@State private var action: Int? = 0

var body: some View {

    NavigationView {
                VStack {
                    NavigationLink(destination: Text("Destination_1"), tag: 1, selection: $action) {
                         Text("123")
                    }
                    NavigationLink(destination: Text("Destination_2"), tag: 3, selection: $action) {
                        EmptyView()
                    }
                    
                    Text("Your Custom View 1")
                        .onTapGesture {
             //perform some tasks if needed before opening Destination view
                            self.action = 1
                    }
                    Text("Your Custom View 2")
                        .onTapGesture {
             //perform some tasks if needed before opening Destination view
                            self.action = 3
                    }
                }
            }
    }
    
    
}

struct ContentView2: View {
    @State var currentDate = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("\(currentDate)")
            .onReceive(timer) { input in
                self.currentDate = input
            }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

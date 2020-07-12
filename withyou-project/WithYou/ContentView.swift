//
//  ContentView.swift
//  WithYou
//
//  Created by kelo on 2020/4/13.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var view_switcher = UserDefaults.isFirstLaunch() ? 4 : 1
    @State var timing: timer = timer()
    @Environment(\.imageCache) var cache: ImageCache
    let Clock = Timer.publish(every: 5, on: .current, in: .common).autoconnect()
    var body: some View {
        HStack {
            if view_switcher == 0 && self.timing.time >= 0 {
                SignUpView(view_switcher: $view_switcher)
            }
            if view_switcher == 1 && self.timing.time >= 0 {
                LoginView(view_switcher: $view_switcher)
            }
            if view_switcher == 2 && self.timing.time >= 0 {
                HomeView_together(url: URL(string: "https://img.cetacis.dev/uploads/big/eb1dc98270f647c1e236ecb56b51a98a.jpg")!,cache: self.cache ,view_swither: $view_switcher)
            }
            if view_switcher == 3 && self.timing.time >= 0 {
                HomeView_person(view_swither: $view_switcher)
            }
            if view_switcher == 4 && self.timing.time >= 0 {
                AnimationView(view_swither: $view_switcher)
            }
            if view_switcher == 5 && self.timing.time >= 0 {
                HomeView_person(view_swither: $view_switcher).onAppear() {
                    self.view_switcher = 3
                }
            }
            
            
        }.onAppear(){
            login
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

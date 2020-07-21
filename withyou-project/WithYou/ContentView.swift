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
                HomeView_together(url: URL(string: "https://withyou.cetacis.dev/api"+User.img_path)!, cache: self.cache ,view_swither: $view_switcher)
            }
            
            if view_switcher == 3 && self.timing.time >= 0 {
                HomeView_person(url: URL(string: "https://withyou.cetacis.dev/api"+User.img_path)!, cache: self.cache ,view_swither: $view_switcher)
            }
            
            if view_switcher == 4 && self.timing.time >= 0 {
                AnimationView(view_swither: $view_switcher)
            }
            
            if view_switcher == 5 && self.timing.time >= 0 {
                HomeView_person(url: URL(string: "https://withyou.cetacis.dev/api"+User.img_path)!, cache: self.cache ,view_swither: $view_switcher).onAppear() {
                    self.view_switcher = 3
                }
            }
            
            if view_switcher == 6 && self.timing.time >= 0 {
                LoadingView(url: URL(string: "https://withyou.cetacis.dev/api"+User.img_path)!, cache: self.cache ,view_swither: $view_switcher).onAppear() {
                    GetFriends()
                    GetMatch { (finished) in
                        if finished {
                            self.view_switcher = 2
                        }
                    }
                }
            }
        }.onAppear(){
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

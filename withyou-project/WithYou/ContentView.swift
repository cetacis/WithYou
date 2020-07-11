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
    var body: some View {
        HStack {
            if view_switcher == 0 {
                SignUpView(view_switcher: $view_switcher)
            }
            if view_switcher == 1 {
                LoginView(view_switcher: $view_switcher)
            }
            if view_switcher == 2 {
                HomeView_together(view_swither: $view_switcher)
            }
            if view_switcher == 3 {
                HomeView_person(view_swither: $view_switcher)
            }
            if view_switcher == 4 {
                AnimationView(view_swither: $view_switcher)
            }
            if view_switcher == 5 {
                HomeView_person(view_swither: $view_switcher).onAppear() {
                    self.view_switcher = 3
                }
            }
        }.onAppear(){
            login
            print(PostLogin(email: "test@test.test", pass: "123"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  addNewPrivateTask.swift
//  WithYou
//
//  Created by kelo on 2020/4/16.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

func isnotempty(_ X:String) -> Bool {
    return X.count > 0
}

struct addNewPrivateTask:View {
    @Binding var addingtask: Bool
    @Binding var IsChanging: Bool
    @State var taskcontent = ""
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.addingtask.toggle()
                }) {
                    Text("Back")
                }
                Spacer()
                if (isnotempty(taskcontent)){
                        Button(action: {
                            var new_task = PrivateTask()
                            new_task.name = self.taskcontent
                            User.PrivateTasks.append(new_task)
                            PostChangeProfile(completion: { (code, msg) in
                                if code == 0 {
                                    print("success")
                                }
                            }, UserData: User)
                            self.IsChanging.toggle()
                            self.addingtask.toggle()
                    }) {
                        Text("Done")
                    }
                    
                }
            }.frame(width: 365).padding(.top,10).padding(.bottom,10)
            LabelTextField(label: "Task", placeHolder: "write your task", icon: "person.circle.fill", text: $taskcontent)
            Spacer()
        }
    }
}

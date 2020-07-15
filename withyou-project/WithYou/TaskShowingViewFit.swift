//
//  TaskShowingViewFit.swift
//  WithYou
//
//  Created by una on 2020/4/15.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import SwiftUI

struct TaskShowingViewFit: View {
    @State var taskID1:Int = 101
    @State var taskID2:Int = 102
    @State var taskID3:Int = 103
    @State var taskID4:Int = 104
    @State var taskID5:Int = 105
    @State var taskID6:Int = 106
    @State var taskID7:Int = 107
    
    var body: some View {
        
        List {
            NavigationLink(destination: AddScheduleDetailFit(taskId: self.$taskID1)) {
                HStack
                    { Image("exercise2").resizable().frame(width:80, height: 100, alignment: .bottom)
                        VStack(alignment: .leading){
                            Text("Fat Loss Plan").font(.system(size:30, design: .rounded)).foregroundColor(.blue)
                            Text("main purpose: reduce fat")
                            Text("everyday tasks sum:10-12")
                            Text("time: 21days")
                        }
                }
            }
            NavigationLink(destination: AddScheduleDetailFit(taskId: self.$taskID2)) {
                HStack
                    { Image("think").resizable().frame(width:80, height: 100, alignment: .bottom)
                        VStack(alignment: .leading){
                            Text("Meditation Plan").font(.system(size:30, design: .rounded)).foregroundColor(.blue)
                            Text("main purpose: concentrate and relax")
                            Text("everyday tasks sum:3-4")
                            Text("time: 7days")
                        }
                }
            }
            NavigationLink(destination: AddScheduleDetailFit(taskId: self.$taskID3)) {
                HStack
                    { Image("yg1").resizable().frame(width:80, height: 100, alignment: .bottom)
                        VStack(alignment: .leading){
                            Text("Introductory Yoga").font(.system(size:30, design: .rounded)).foregroundColor(.blue)
                            Text("main purpose: Learn about yoga")
                            Text("everyday tasks sum:5-6")
                            Text("time: 7days")
                        }
                }
            }
            NavigationLink(destination:AddScheduleDetailFit(taskId: self.$taskID4)) {
                HStack
                    { Image("yg2").resizable().frame(width:80, height: 100, alignment: .bottom)
                        VStack(alignment: .leading){
                            Text("Intermediate Yoga").font(.system(size:30, design: .rounded)).foregroundColor(.blue)
                            Text("main purpose: adjust body")
                            Text("everyday tasks sum:10-12")
                            Text("time: 21days")
                        }
                }
            }
            NavigationLink(destination: AddScheduleDetailFit(taskId: self.$taskID5)) {
                HStack
                    { Image("bike3").resizable().frame(width:80, height: 100, alignment: .bottom)
                        VStack(alignment: .leading){
                            Text("Cycling").font(.system(size:30, design: .rounded)).foregroundColor(.blue)
                            Text("main purpose: exercise muscle")
                            Text("everyday tasks sum:2")
                            Text("time: 7days")
                        }
                }
            }
            NavigationLink(destination: AddScheduleDetailFit(taskId: self.$taskID6)) {
                HStack
                    { Image("walk").resizable().frame(width:80, height: 100, alignment: .bottom)
                        VStack(alignment: .leading){
                            Text("Walk Quickly").font(.system(size:30, design: .rounded)).foregroundColor(.blue)
                            Text("main purpose:develop heart and lung function")
                            Text("everyday tasks sum:1-2")
                            Text("time: 7days")
                        }
                }
            }
            NavigationLink(destination: AddScheduleDetailFit(taskId: self.$taskID7)) {
                HStack
                    { Image("exercise5").resizable().frame(width:80, height: 100, alignment: .bottom)
                        VStack(alignment: .leading){
                            Text("Keep Fit").font(.system(size:30, design: .rounded)).foregroundColor(.blue)
                            Text("main purpose: build muscle")
                            Text("everyday tasks sum:10-12")
                            Text("time: 21days")
                        }
                }
            }
            
            
            
            
        }
    }
}

struct TaskShowingViewFit_Previews: PreviewProvider {
    static var previews: some View {
        TaskShowingViewFit()
    }
}

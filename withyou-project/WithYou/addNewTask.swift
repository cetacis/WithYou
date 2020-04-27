//
//  addNewTask.swift
//  WithYou
//
//  Created by una on 2020/4/15.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import SwiftUI
struct ScheduleInfo{
    var scheduleType = ""
    var scheduleTypeNum:Int = 0
}

enum ScheduleType : CaseIterable, Hashable, Identifiable { // 1
    case fitness
    case study
    case read
    case life
    
    var id: UUID { UUID() }
    
    var name: String {
        switch self {
        case .fitness: return "fitness"
        case .study: return "study"
        case .read: return "read"
        case .life: return "life"
        }
    }
}

struct addNewTask: View {
    @Binding var showingaddtask : Bool
    @State var scheduleInfo = ScheduleInfo()
    @State var isnavi = true
    var body: some View {
        NavigationView{
            VStack{
                HStack{ Spacer()
                    Button(action: {
                        self.showingaddtask.toggle()
                    }) {
                        Text("Done")
                    }
                }.frame(width: 365).padding(.top,10)
                                  
                Form{
                    Section(header: Text("new schedule type").font(.headline)) {
                        Picker(selection: $scheduleInfo.scheduleType, label: Text("Shedule Type")) {
                            ForEach(ScheduleType.allCases) { type in // 4.1
                                Text(type.name).tag(type.name)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    switchTaskType()
                }
            }
            .navigationBarTitle("Add tasks")
            .navigationBarHidden(isnavi)
            .onAppear() {
                self.isnavi = true
            }
            
        }
    }
        
        
    

    func switchTaskType() -> AnyView {
        switch scheduleInfo.scheduleType{
        case "fitness":
            return AnyView(TaskShowingViewFit())
            
        case "study":
            return AnyView(TaskShowingViewStu())
            
        case "read":
            return AnyView(TaskShowingViewStu())
            
        case "life":
            return AnyView(TaskShowingViewStu())
            
        default:
            return AnyView(TaskShowingViewDefault())
        }
        
    }

}

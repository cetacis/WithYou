//
//  AddScheduleDetail.swift
//  WithYou
//
//  Created by una on 2020/4/15.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import SwiftUI

// to ensure there is only one task for one type
func checkType(checkedType:Int)->Bool{
    for task in User.TogetherTasks{
        if task.tasktype == checkedType{
            return true
        }
    }
    return false
}

func addNewTaskFunc(name:String,partnerEmail:String){
    var new_task = TogetherTask()
    new_task.name = name
    //todo: 匹配的好友邮箱（匹配函数）
    new_task.friendEmail = partnerEmail
    var flag = false
    for index in 0..<User.Friends.count {
        if User.Friends[index] == partnerEmail {
            flag = true
            break
        }
    }
    
    
    //todo: 向togethertasks 发送 new_task 并加入非好友友人
    /*try! realm.write {
     User.togethertasks.append(new_task)
     if !flag {
     User.Friends.append(new_task.friend_email)
     }
     }*/
}

func matchPartner()->String{
    return "Admin@cetacis.dev"
}

struct AddScheduleDetailFit: View {
    var type = 1
    @State var altCannotMatching = false
    @Binding var taskId:Int
    @State var isMatching = false
    var body: some View {
        VStack{
            List{
                
                VStack{
                    Text("Fat Loss Plan").font(.system(size: 28,design: .rounded)).fontWeight(.heavy).foregroundColor(.blue).offset(x:60)
                    Image("exercise").resizable().frame(width:250, height: 400).shadow(radius: 13).overlay(
                        Rectangle().stroke(Color.white, lineWidth: 4))
                    .offset(x:60)
                    
                }
                
                HStack{
                    Text("Everyday time: ").fontWeight(.heavy).foregroundColor(Color(red: 215/255, green: 86/255, blue: 33/255))
                    Text("about 40 min")
                }
                HStack{
                    Text("Everyday tasks: ").fontWeight(.heavy).fontWeight(.heavy).foregroundColor(Color(red: 215/255, green: 86/255, blue: 33/255))
                    Text("about 8 items")
                }
                HStack{
                    Text("Example:").fontWeight(.heavy).fontWeight(.heavy).foregroundColor(Color(red: 215/255, green: 86/255, blue: 33/255))
                    Text(" 1. One leg bent legs both ends  (*12)\n 2. Knee flexion  (*15)\n 3. Sicilian Belly  (*15)\n 4. Pedal in the air  (*30'')\n 5. Flat support  (*30'')\n 6.Abdominal stretch  (*30'')\n 7. Running  (*3km) \n 8. Strict diet control \n 9. Fun task : show diet with partner~")
                }
                VStack{
                    Text("You can share your schedule with your partner, you can do these difficult tasks with your frinds. Someone in the world is fighting with you. Now, let's find your partner, who will do these tasks")
                    Text("withYou").fontWeight(.heavy).foregroundColor(.blue)
                }
                Button(
                    action: {
                        print("button")
                        self.altCannotMatching = checkType(checkedType: self.type)
                        if(!self.altCannotMatching){
                            self.isMatching = true
                            let tasks = ["Leg bent","Knee flexion","SicilLian Belly","Pedal in air","Flat support","Stretch","Runsning","Diet control","Show diet"]
                            for task in tasks{
                                addNewTaskFunc(name: task, partnerEmail:matchPartner() )
                            }
                            
                        }
                },
                    label: {Text("Find Your Partner and open the travel").font(.system(size: 17,design: .rounded)).fontWeight(.heavy).padding().background(Color.yellow).cornerRadius(100).foregroundColor(Color(red: 130/255, green: 130/255, blue: 130/255)).offset(x:20).font(.system(size:15,design:.rounded))})     
            }
        }.offset(y: 5).alert(isPresented: $altCannotMatching) {
            Alert(title: Text("You already have a task (or matching) in this type , you can't match a new partner before you finish the schedule"), dismissButton: .default(Text("OK")))
        }.alert(isPresented: $isMatching) {
            Alert(title: Text("The matching request has been received, please pay attention to your Inbox to check if you have found your partner."), dismissButton: .default(Text("OK")))
        }
    }
}

struct AddScheduleDetailStu: View {
    var type = 2
    @State var altCannotMatching = false
    @Binding var taskId:Int
    var body: some View {
        VStack{
            List{
                
                VStack{
                    Text("Fat Loss Plan").font(.system(size: 28,design: .rounded)).fontWeight(.heavy).foregroundColor(.blue).offset(x:60)
                    Image("exercise").resizable().frame(width:250, height: 400).shadow(radius: 13).overlay(
                        Rectangle().stroke(Color.white, lineWidth: 4))
                    .offset(x:60)
                    
                }
                
                HStack{
                    Text("Everyday time: ").fontWeight(.heavy).foregroundColor(Color(red: 215/255, green: 86/255, blue: 33/255))
                    Text("about 40 min")
                }
                HStack{
                    Text("Everyday tasks: ").fontWeight(.heavy).fontWeight(.heavy).foregroundColor(Color(red: 215/255, green: 86/255, blue: 33/255))
                    Text("about 8 items")
                }
                HStack{
                    Text("Example:").fontWeight(.heavy).fontWeight(.heavy).foregroundColor(Color(red: 215/255, green: 86/255, blue: 33/255))
                    Text(" 1. One leg bent legs both ends  (*12)\n 2. Knee flexion  (*15)\n 3. Sicilian Belly  (*15)\n 4. Pedal in the air  (*30'')\n 5. Flat support  (*30'')\n 6.Abdominal stretch  (*30'')\n 7. Running  (*3km) \n 8. Strict diet control \n 9. Fun task : show diet with partner~")
                }
                VStack{
                    Text("You can share your schedule with your partner, you can do these difficult tasks with your frinds. Someone in the world is fighting with you. Now, let's find your partner, who will do these tasks")
                    Text("withYou").fontWeight(.heavy).foregroundColor(.blue)
                }
                Button(
                    action: {
                        print("button")
                        self.altCannotMatching = checkType(checkedType: self.type)
                        if(!self.altCannotMatching){
                            let tasks = ["Leg bent","Knee flexion","SicilLian Belly","Pedal in air","Flat support","Stretch","Runsning","Diet control","Show diet"]
                            for task in tasks{
                                addNewTaskFunc(name: task, partnerEmail:matchPartner() )
                            }
                        }
                },
                    label: {Text("Find Your Partner and open the travel").font(.system(size: 17,design: .rounded)).fontWeight(.heavy).padding().background(Color.yellow).cornerRadius(100).foregroundColor(Color(red: 130/255, green: 130/255, blue: 130/255)).offset(x:20).font(.system(size:15,design:.rounded))})
            }
        }.offset(y: 5).alert(isPresented: $altCannotMatching) {
            Alert(title: Text("You already have a task (or matching) in this type , you can't match a new partner before you finish the schedule"), dismissButton: .default(Text("OK")))
        }
    }
}

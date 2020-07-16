//
//  AddScheduleDetail.swift
//  WithYou
//
//  Created by una on 2020/4/15.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import SwiftUI




func addNewTaskFunc(name:String,partnerEmail:String,tasknumeber:Int){
    var new_task = TogetherTask(name: name, number: tasknumeber, comment: "", friendEmail: partnerEmail, IsFinished: false)
    User.TogetherTasks.append(new_task)
    var flag = false
    for index in 0..<User.Friends.count {
        if User.Friends[index] == partnerEmail {
            flag = true
            break
        }
    }
    if flag == false {
        User.Friends.append(partnerEmail)
    }
    //todo: change the profile post
}

func trymatchPartner()->String{
    var returnString:String = ""
    PostAddMatchQueue(completion: { (code, msg) in
        if code == 0{
            returnString = msg
            User.Messages.append(Message(msg: "You have matched your partner in the task! Just do it and enjoy yourself!", IsUser: false, IsRead: false))
        }
        
        }, email: User.email,taskid: TaskID)
    TaskID = 0
    return returnString
}

struct AddScheduleDetailFit: View {
    @State var altCannotMatching = false
    @State var hasmatched = false
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
                        //try entering the matching quene
                        PostAddMatchQueue(completion: { (code, msg) in
                            print(code)
                            print(msg)
                            if code == 0{
                                
                                if msg == "add queue success"{
                                    TaskID = self.taskId
                                    print(TaskID)
                                    self.isMatching = true
                                }else{
                                    User.partner = msg
                                    self.hasmatched = true
                                }
                            }else{
                                self.isMatching = true
                                self.altCannotMatching = true
                            }
                        }, email: User.email,taskid: self.taskId)
                    
                        if(self.hasmatched){
                            self.isMatching = true
                            
                            let tasks = Tasks[self.taskId]
                            print("TaskID:")
                            print(self.taskId)
                            print(tasks)
                            for task in tasks{
                                print(task)
                                addNewTaskFunc(name: task, partnerEmail:User.partner,tasknumeber:self.taskId)
                            }
                            
                        }
                },
                    label: {Text("Find Your Partner and open the travel").font(.system(size: 17,design: .rounded)).fontWeight(.heavy).padding().background(Color.yellow).cornerRadius(100).foregroundColor(Color(red: 130/255, green: 130/255, blue: 130/255)).offset(x:20).font(.system(size:15,design:.rounded))})
            }
        }.offset(y: 5)
        .alert(isPresented: $isMatching) {
            Alert(title: self.altCannotMatching ? Text("You already have a task (or matching), you can't match a new partner before you finish the schedule") : Text("The matching request has been received, please pay attention to your Inbox to check if you have found your partner."), dismissButton: .default(Text("OK")))
        }.onAppear(perform: {print(self.isMatching)})
    }
}


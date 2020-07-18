//
//  AddScheduleDetail.swift
//  WithYou
//
//  Created by una on 2020/4/15.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import SwiftUI


struct AddScheduleDetailFit: View {
    @State var altCannotMatching = false
    @State var hasmatched = false
    @Binding var taskId:Int
    @State var altertMettion = false
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
                        
                        if User.partner == "" {
                            User.CurrentTaskId = self.taskId
                            PostAddMatchQueue(completion: { (code, msg) in
                            print("The PostAddMatchQueue")
                            print(code)
                            print(msg)
                            if code == 0{//成功添加入队列
                                User.Messages.append(Message(msg: "You are matched now \n\n your partner is on the way to you...", IsUser: false, IsRead: false))
                                PostChangeProfile(completion: {_,_ in }, UserData: User)
                                self.altCannotMatching = false
                                self.altertMettion = true
        
                            }else{//已经有正在配对的任务
                                self.altertMettion = true
                                self.altCannotMatching = true
                            }
                            }, email: User.email,taskid: self.taskId)}else{
                             self.altertMettion = true
                            self.altCannotMatching = true
                        }
                },
                    label: {Text("Find Your Partner and open the travel").font(.system(size: 17,design: .rounded)).fontWeight(.heavy).padding().background(Color.yellow).cornerRadius(100).foregroundColor(Color(red: 130/255, green: 130/255, blue: 130/255)).offset(x:20).font(.system(size:15,design:.rounded))})
                    .alert(isPresented: $altertMettion) {
                        Alert(title: self.altCannotMatching ? Text("You already have a task (or matching), you can't match a new partner before you finish the schedule(or find a partner)") : Text("The matching request has been received, please pay attention to your Inbox to check if you have found your partner."), dismissButton: .default(Text("OK")))
                }
            }.offset(y: 5)
        }.onAppear(perform: {print(self.altertMettion)})
    }
}


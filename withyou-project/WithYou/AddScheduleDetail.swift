//
//  AddScheduleDetail.swift
//  WithYou
//
//  Created by una on 2020/4/15.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import SwiftUI

struct AddScheduleDetailFit: View {
    @State var matching = false
    @State var timeLine = false
    @State var timeLine2 = false
    private func delayText() {
        // Delay of 7.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.timeLine = true
            self.timeLine2 = true
            
        }
    }
    private func addNewTask(name:String){
        var new_task = TogetherTask()
        new_task.name = name
        //todo: 匹配的好友邮箱（匹配函数）
        new_task.friendEmail = "Admin@cetacis.dev"
        var flag = false
        for index in 0..<User.Friends.count {
            if User.Friends[index] == new_task.friendEmail {
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
                if(User.TogetherTasks.count != 0){Text("You already have a partner, you can't match a new partner before you finish the schedule")}
                Button(
                    action: {
                        print("button")
                        if(User.TogetherTasks.count == 0){
                        self.matching.toggle()
                        self.addNewTask(name: "Leg bent")
                        self.addNewTask(name: "Knee flexion")
                        self.addNewTask(name: "SicilLian Belly")
                        self.addNewTask(name: "Pedal in air")
                        self.addNewTask(name: "Flat support")
                        self.addNewTask(name: "Stretch")
                        self.addNewTask(name: "Runsning")
                        self.addNewTask(name: "Diet control")
                        self.addNewTask(name: "Show diet")}
                        
                        
                },
                    label: {Text("Find Your Partner and open the travel").font(.system(size: 17,design: .rounded)).fontWeight(.heavy).padding().background(Color.yellow).cornerRadius(100).foregroundColor(Color(red: 130/255, green: 130/255, blue: 130/255)).offset(x:20).font(.system(size:15,design:.rounded))})
                
            }
            // TODO: 這裡動畫的邏輯有大問題，但是做到了如果匹配了就不能二次匹配了。並且匹配3秒後會匹配成功
            if(matching && !timeLine2){
                MatchingAnimation().onAppear(perform: delayText).frame(width:UIScreen.main.bounds.width-50)}
            if(timeLine2 && !timeLine){
                Text("You already have a partner, you can't match a new partner before you finish the schedule")
            }
        }.offset(y: 5).alert(isPresented: $timeLine) {
            Alert(title: Text("succeed"), dismissButton: .default(Text("OK")))
        }
        
    }
}

struct AddScheduleDetailStu: View {
    @State var matching = false
    @State var timeLine = false
    @State var timeLine2 = false
    private func delayText() {
        // Delay of 7.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.timeLine = true
            self.timeLine2 = true
            
        }
    }
    private func addNewTask(name:String){
        var new_task = TogetherTask()
        new_task.name = name
        //todo: 匹配的好友邮箱（匹配函数）
        new_task.friendEmail = "Admin@cetacis.dev"
        var flag = false
        for index in 0..<User.Friends.count {
            if User.Friends[index] == new_task.friendEmail {
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
                if(User.TogetherTasks.count != 0){Text("You already have a partner, you can't match a new partner before you finish the schedule")}
                Button(
                    action: {
                        print("button")
                        if(User.TogetherTasks.count == 0){
                        self.matching.toggle()
                        self.addNewTask(name: "Leg bent")
                        self.addNewTask(name: "Knee flexion")
                        self.addNewTask(name: "SicilLian Belly")
                        self.addNewTask(name: "Pedal in air")
                        self.addNewTask(name: "Flat support")
                        self.addNewTask(name: "Stretch")
                        self.addNewTask(name: "Runsning")
                        self.addNewTask(name: "Diet control")
                        self.addNewTask(name: "Show diet")}
                        
                        
                },
                    label: {Text("Find Your Partner and open the travel").font(.system(size: 17,design: .rounded)).fontWeight(.heavy).padding().background(Color.yellow).cornerRadius(100).foregroundColor(Color(red: 130/255, green: 130/255, blue: 130/255)).offset(x:20).font(.system(size:15,design:.rounded))})
                
            }
            // TODO: 這裡動畫的邏輯有大問題，但是做到了如果匹配了就不能二次匹配了。並且匹配3秒後會匹配成功
            if(matching && !timeLine2){
                MatchingAnimation().onAppear(perform: delayText).frame(width:UIScreen.main.bounds.width-50)}
            if(timeLine2 && !timeLine){
                Text("You already have a partner, you can't match a new partner before you finish the schedule")
            }
        }.offset(y: 5).alert(isPresented: $timeLine) {
            Alert(title: Text("succeed"), dismissButton: .default(Text("OK")))
        }
        
    }
}

struct AddScheduleDetail_Previews: PreviewProvider {
    static var previews: some View {
        AddScheduleDetailStu()
    }
}

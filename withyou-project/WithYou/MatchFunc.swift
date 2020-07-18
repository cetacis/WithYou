//
//  MatchFunc.swift
//  WithYou
//
//  Created by una on 2020/7/17.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI
func getMatched(){
    
    if User.CurrentTaskId > 0{
        let date = Date()
     PostGetMatch(completion: {(code,msg) in
        var flag: Bool = false
        print("PostGetMatch")
        print(code)
        print(msg)
        if code == 0{
            
            if User.TogetherTasks.count == 0{//如果A方B方都没进行get 此时A方get
             PostChangeProfile(completion: {_,_ in
                for friend in User.Friends{
                if friend == msg{
                    flag = true
                }
            }
           if !flag {//A方将B方加入朋友（如果A方没有这个朋友）
            User.Friends.append(msg)
            }
            let tid = User.CurrentTaskId//读取A方等待配对的taskid 进而读取到Tasks[]
            for task in Tasks[tid]{
                User.TogetherTasks.append(TogetherTask(name: task, number: tid, comment: "", friendEmail: msg, IsFinished: false))
            }//A方加入TogetherTasks
            User.Messages.append(Message(msg: "You have find your partner to finish the new task, hope you can finish your goal and enjoy it.\n\nYour partner's email is:\n\n\(msg) \n\n You can find him in your friends' list.\n\n\n\n\n\n\n\n\n\n\n\(date)", IsUser: false, IsRead: false))
                //A方获得信息
            User.partner.append(msg)//A方将B方作为partner
                print("User:")
                print(User)
            User.CurrentTaskId = 0//A方taskid置为0
                print("#4")
                GetFriendInfo(completion: { (Rata) in
                    var part = Rata
                    for task in Tasks[tid]{
                        part.TogetherTasks.append(TogetherTask(name: task, number: tid, comment: "", friendEmail: User.email, IsFinished: false))
                    }//A方加入TogetherTasks
                    if !flag {//B方将A方加入朋友（如果A方没有这个朋友）
                    part.Friends.append(User.email)
                    }
                    part.Messages.append(Message(msg: "You have find your partner to finish the new task, hope you can finish your goal and enjoy it.\n\nYour partner's email is:\n\n\(msg) \n\n You can find him in your friends' list.\n\n\n\n\n\n\n\n\n\n\n\(date)", IsUser: false, IsRead: false))//B方加入信息
                    part.partner.append(User.email)//B方加入A方为拍档
                    part.CurrentTaskId = 0 //B方taskid置为0
                     print("#5")
                    Partner = part
                    print("Partner:")
                    print(Partner)
                     print("#6")
                    PostChangeProfile(completion: {_,_ in
                    }, UserData: part)//发送B方修改
                }, email: msg)
            }, UserData: User)}//发送A方修改
        }
        else{print("haven't be matched")}
     }, email: User.email, taskid: User.CurrentTaskId)}
}

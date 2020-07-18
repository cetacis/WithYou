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
    
    if User.CurrentTaskId != 0{
        let date = Date()
     PostGetMatch(completion: {(code,msg) in
        var flag: Bool = false
        print("PostGetMatch")
        print(code)
        print(msg)
        if code == 0{
            for friend in User.Friends{
                if friend == msg{
                    flag = true
                }
            }
        if !flag {
            User.Friends.append(msg)
            }
            let tid = User.CurrentTaskId
            for task in Tasks[tid]{
                User.TogetherTasks.append(TogetherTask(name: task, number: tid, comment: "", friendEmail: msg, IsFinished: false))
            }
            User.Messages.append(Message(msg: "You have find your partner to finish the new task, hope you can finish your goal and enjoy it.\n\nYour partner's email is:\n\n\(msg) \n\n You can find him in your friends' list.\n\n\n\n\n\n\n\n\n\n\n\(date)", IsUser: false, IsRead: false))
            User.partner.append(msg)
            User.CurrentTaskId = 0
            PostChangeProfile(completion: {_,_ in }, UserData: User)
        }
        else{print("haven't be matched")}
     }, email: User.email, taskid: User.CurrentTaskId)}
}

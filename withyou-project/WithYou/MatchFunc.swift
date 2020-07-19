//
//  MatchFunc.swift
//  WithYou
//
//  Created by una on 2020/7/17.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI
<<<<<<< HEAD
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
=======

func GetMatch() {
    // get match
    PostGetMatch(completion: { (code, msg) in
        if code == 0 {
            // get time
            let date = Date()
            // match success
            let friendemail = msg // friend email
            // add yourself task
            for task in Tasks[User.CurrentTaskId]{
                User.TogetherTasks.append(TogetherTask(
                                            name: task,
                                            number: User.CurrentTaskId,
                                            comment: "",
                                            friendEmail: friendemail,
                                            IsFinished: false
                                        )
                )
>>>>>>> 9984aa44fc91d7c5343484d18c1ffe07e8e158c8
            }
            //add yourself message
            User.Messages.append(Message(
                                    msg: "You have find your partner to finish the new task, hope you can finish your goal and enjoy it.\n\nYour partner's email is:\n\n\(friendemail) \n\n You can find him in your friends' list.\n\n\n\n\n\n\n\n\n\n\n\(date)",
                                    IsUser: false,
                                    IsRead: false
                                )
            )
            //add yourself friend
            User.Friends.append(friendemail)
            // save yourself info
            PostChangeProfile(completion: { (code, msg) in
                if (code == 0) {
                    print("Saved success")
                }
            }, UserData: User)
            // change check friend info
            GetFriendInfo(completion: { (UserInfo) in
                if UserInfo.TogetherTasks.count == 0 {
                    // friends haven't login
                    var ChangeInfo = UserInfo
                    ChangeInfo.password = "a98f9eaa6ff801c24e30a6f4619b23b59393ceea9b7b4c65700a5a38cff95c98"
                    // change friends together task
                    for task in Tasks[User.CurrentTaskId]{
                        ChangeInfo.TogetherTasks.append(TogetherTask(
                                                    name: task,
                                                    number: User.CurrentTaskId,
                                                    comment: "",
                                                    friendEmail: User.email,
                                                    IsFinished: false
                                                )
                        )
                    }
<<<<<<< HEAD
                    part.Messages.append(Message(msg: "You have find your partner to finish the new task, hope you can finish your goal and enjoy it.\n\nYour partner's email is:\n\n\(msg) \n\n You can find him in your friends' list.\n\n\n\n\n\n\n\n\n\n\n\(date)", IsUser: false, IsRead: false))//B方加入信息
                    part.partner.append(User.email)//B方加入A方为拍档
                    part.password = "a98f9eaa6ff801c24e30a6f4619b23b59393ceea9b7b4c65700a5a38cff95c98"
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
=======
                    PostChangeProfile(completion: { (code, int) in
                        if code == 114514 {
                            print(msg)
                        }
                    }, UserData: ChangeInfo)
                    Partner = ChangeInfo
                } else {
                    Partner = UserInfo
                }
            }, email: friendemail)
>>>>>>> 9984aa44fc91d7c5343484d18c1ffe07e8e158c8
        }
    }, email: User.email, taskid: User.CurrentTaskId)
}

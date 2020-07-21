//
//  MatchFunc.swift
//  WithYou
//
//  Created by una on 2020/7/17.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

func GetMatch(completion: @escaping (_ IsFinished: Bool) -> ()) {
    // get match
    PostGetMatch(completion: { (code, msg) in
        if code == 0 {
            // get time
            let date = Date()
            // match success
            let friendemail = msg // friend email
            // add yourself task
            User.TogetherTasks = [TogetherTask]()
            for task in Tasks[User.CurrentTaskId]{
                User.TogetherTasks.append(TogetherTask(
                                            name: task,
                                            number: User.CurrentTaskId,
                                            comment: "",
                                            friendEmail: friendemail,
                                            IsFinished: false
                                        )
                )
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
            User.partner = friendemail
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

                    PostChangeProfile(completion: { (code, int) in
                        if code == 114514 {
                            print(msg)
                        }
                    }, UserData: ChangeInfo)
                    Partner = ChangeInfo
                    completion(true)
                } else {
                    Partner = UserInfo
                    completion(true)
                }
            }, email: friendemail)
        } else {
            if User.partner.count != 0 {
                GetFriendInfo(completion: { (UserInfo) in
                    Partner = UserInfo
                    completion(true)
                }, email: User.partner)
            } else {
                completion(true)
            }
        }
    }, email: User.email, taskid: User.CurrentTaskId)
}

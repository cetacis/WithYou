//
//  File.swift
//  WithYou
//
//  Created by una on 2020/4/23.
//  Copyright © 2020 邓萌达. All rights reserved.
//

//
//  File.swift
//  WithYou
//
//  Created by kelo on 2020/4/14.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation



var PostImagePath : URL? = nil

struct TogetherTask {
    var name: String
    var number: Int
    var comment: String
    var friendEmail: String
    var IsFinished: Bool
    init() {
        self.name = ""
        self.number = -1
        self.comment = ""
        self.friendEmail =  ""
        self.IsFinished = false
    }
    
}

struct PrivateTask {
    var name: String
    var number: Int
    var IsFinished: Bool
    init() {
        self.name = ""
        self.number = -1
        self.IsFinished = false
    }
    
}

struct Message {
    var msg: String
    var IsUser:Bool
    var IsRead: Bool
    init() {
        self.msg = ""
        self.IsUser = false
        self.IsRead = false
    }
}

struct UserInfo {
    var username: String
    var email: String
    var mobile: String
    var password: String
    var bio: String
    var age: String
    var sex: String
    var birthday: String
    var constellation: String
    var imgpath: String
    var TogetherTasks: [TogetherTask]
    var PrivateTasks: [PrivateTask]
    var Messages: [Message]
    var Friends: [String]
    
    init() {
        self.username = "Cetacis"
        self.email = "kelo@cetacis.dev"
        self.password = "password"
        self.age = "20"
        self.bio = "life is cetacis. Prprpr"
        self.mobile = "+86 15358764577"
        self.constellation = "tiger"
        self.birthday = "2000-1-1"
        self.sex = "male"
        self.imgpath = ""
        self.TogetherTasks = [TogetherTask]()
        self.PrivateTasks = [PrivateTask]()
        self.Messages = [Message]()
        self.Friends = [String]()
    }
}

var User = UserInfo()

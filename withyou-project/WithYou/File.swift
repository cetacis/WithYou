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
import SwiftUI


var PostImagePath : URL? = nil

struct LoginInfo: Codable {
    var email: String
    var pass: String
}

struct TogetherTask: Codable {
    var name: String
    var number: Int
    var comment: String
    var friendEmail: String
    var IsFinished: Bool

}

struct PrivateTask: Codable {
    var name: String
    var number: Int
    var IsFinished: Bool
    init() {
        self.name = ""
        self.number = -1
        self.IsFinished = false
    }
    
}

struct Message: Codable {
    var msg: String
    var IsUser:Bool
    var IsRead: Bool
}

struct UserInfo: Codable{
    var username: String
    var email: String
    var mobile: String
    var password: String
    var bio: String
    var age: String
    var sex: String
    var birthday: String
    var constellation: String
    var img_path: String
    var TogetherTasks: [TogetherTask]
    var PrivateTasks: [PrivateTask]
    var Messages: [Message]
    var Friends: [String]
    var partner : String
    var CurrentTaskId:Int
    
    
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
        self.img_path = ""
        self.TogetherTasks = [TogetherTask]()
        self.PrivateTasks = [PrivateTask]()
        self.Messages = [Message]()
        self.Friends = [String]()
        self.partner = ""
        self.CurrentTaskId = 0
    }
}

struct TaskQuue: Codable {
    var TaskId: Int
    var Email: String
}

var User = UserInfo()
var Partner = UserInfo()
var temFriend = UserInfo()

var Tasks = [[],
    ["Leg bent","Knee flexion","SicilLian Belly","Pedal in air","Flat support","Stretch","Runsning","Diet control","Show diet"]

]

var Friends = [UserInfo]()

var ImgDict: [String:Image] = [String:Image]()



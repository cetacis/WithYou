//
//  File.swift
//  WithYou
//
//  Created by kelo on 2020/4/14.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class PrivateTasks:Object {
    @objc dynamic var Name: String
    @objc dynamic var number: Int
    @objc dynamic var comment: String
    required init() {
        self.comment = ""
        self.number = 0
        self.Name = ""
    }
    let owners = LinkingObjects(fromType: PersonInfo.self, property: "privatetasks")
}

class TogetherTasks:Object {
    @objc dynamic var Name: String
    @objc dynamic var number: Int
    @objc dynamic var comment: String
    @objc dynamic var friend_email: String
    @objc dynamic var isFinished: Bool
    required init() {
        self.comment = ""
        self.number = 0
        self.Name = ""
        self.friend_email = ""
        self.isFinished = false
    }
    let owners = LinkingObjects(fromType: PersonInfo.self, property: "togethertasks")
}

class PersonInfo: Object {
    @objc dynamic var username: String
    @objc dynamic var email: String
    @objc dynamic var password: String
    @objc dynamic var age: String
    @objc dynamic var bio: String
    @objc dynamic var mobile: String
    @objc dynamic var star: String
    @objc dynamic var Blood: String
    @objc dynamic var BirthDay: String
    @objc dynamic var sex: String
    required init() {
        self.username = "Cetacis"
        self.email = "kelo@cetacis.dev"
        self.password = "password"
        self.age = "20"
        self.bio = "life is cetacis. Prprpr"
        self.mobile = "+86 15358764577"
        self.star = "tiger"
        self.Blood = "A"
        self.BirthDay = "2000-1-1"
        self.sex = "male"
    }
    override static func primaryKey() -> String? {
        return "email"
    }
    let privatetasks = List<PrivateTasks>()
    let togethertasks = List<TogetherTasks>()
    let Friends = List<String>()
}


var User = PersonInfo()
let syncServerURL = URL(string: "https://ioswithyou.us1.cloud.realm.io")!
let credentials = SyncCredentials.usernamePassword(username: "admin", password: "dmd123123")

let login: () = SyncUser.logIn(with: credentials, server: syncServerURL, onCompletion: { user, err in
    if let _ = user {
        // User is logged in
    } else if let error = err {
        fatalError(error.localizedDescription)
    }
})
let DBURL = URL(string: "realms://ioswithyou.us1.cloud.realm.io/IOS")!
let user = SyncUser.current!
let config = user.configuration(realmURL: DBURL, fullSynchronization: true);
let realm = try! Realm(configuration: config)

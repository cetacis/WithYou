//
//  PostGetUserInfo.swift
//  WithYou
//
//  Created by 邓萌达 on 13/7/20.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


func PostGetUserInfo(completion: @escaping (_ RtData: UserInfo) -> (), email:String, pass: String) {
    var UserData: UserInfo = UserInfo()
    let para = LoginInfo(email: email, pass: pass)
    AF.request("https://mbp.cetacis.dev/api/UserInfo",
               method: .post,
               parameters: para
    ).responseJSON { (response) in
        let json = JSON(response.data!)
        print(json)
        UserData.birthday = json["birthday"].string!
        UserData.constellation = json["constellation"].string!
        UserData.bio = json["bio"].string!
        UserData.imgpath = json["img_path"].string!
        UserData.Friends = json["friends"].arrayObject! as! [String]
        UserData.mobile = json["mobile"].string!
        UserData.PrivateTasks = json["private_tasks"].arrayObject! as! [PrivateTask]
        UserData.username = json["username"].string!
        UserData.password = json["password"].string!
        UserData.TogetherTasks = json["together_tasks"].arrayObject! as! [TogetherTask]
        UserData.sex = json["sex"].string!
        UserData.email = json["email"].string!
        UserData.age = json["age"].string!
        UserData.Messages = json["messages"].arrayObject! as! [Message]
        print(UserData)
        completion(UserData)
    }
}


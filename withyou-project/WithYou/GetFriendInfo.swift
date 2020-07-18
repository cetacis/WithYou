//
//  GetFriendInfo.swift
//  WithYou
//
//  Created by 邓萌达 on 14/7/20.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

func GetFriendInfo(completion: @escaping (_ RtData: UserInfo) -> (), email:String) {
    var UserData: UserInfo = UserInfo()
    let para = LoginInfo(email: email, pass: "")
    AF.request("https://withyou.cetacis.dev/api/GetFriend",
               method: .post,
               parameters: para
    ).responseJSON { (response) in
        do {
            UserData = try JSONDecoder().decode(UserInfo.self, from: response.data!)
            completion(UserData)
        } catch {
            print(error)
        }
    }
}

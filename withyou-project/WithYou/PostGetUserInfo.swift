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
      //  print(json)
        do {
            UserData = try JSONDecoder().decode(UserInfo.self, from: response.data!)
            completion(UserData)
        } catch {
            print(error)
        }
    }
}


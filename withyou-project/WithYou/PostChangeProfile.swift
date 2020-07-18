//
//  PostChangeProfile.swift
//  WithYou
//
//  Created by 邓萌达 on 14/7/20.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

func PostChangeProfile(completion: @escaping (_ code: Int, _ msg: String) -> (), UserData: UserInfo) {
    do {
        let jsonData = try JSONEncoder().encode(UserData)
        let session = URLSession(configuration: .default)
        let url = "https://withyou.cetacis.dev/api/ChangeProfile"
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        let task = session.dataTask(with: request) {(data, response, error) in
            do {
                let r = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let code = r.value(forKey: "code") as! Int
                let msg = r.value(forKey: "msg") as! String
                completion(code, msg)
            } catch {
                let code = 500
                let msg = "Connect Server error"
                completion(code, msg)
            }
        }
        task.resume()
    } catch {
        print(error)
    }
}


func teach() {
    // get match
    PostGetMatch(completion: { (code, msg) in
        if code == 0 {
            // match success
            let friendemail = msg // friend email
            // add yourself task
            User.TogetherTasks = [TogetherTask]() // do somthing // you can replace directly do not check if added
            // change check friend info
            GetFriendInfo(completion: { (UserInfo) in
                if UserInfo.TogetherTasks.count == 0 {
                    // friends haven't login
                    var ChangeInfo = UserInfo
                    ChangeInfo.password = "a98f9eaa6ff801c24e30a6f4619b23b59393ceea9b7b4c65700a5a38cff95c98"
                    // change friends together task
                    ChangeInfo.TogetherTasks = [TogetherTask]() // do something
                    PostChangeProfile(completion: { (code, int) in
                        if code == 114514 {
                            print("success")
                        }
                    }, UserData: ChangeInfo)
                }
            }, email: friendemail)
        }
    }, email: User.email, taskid: User.CurrentTaskId)
}

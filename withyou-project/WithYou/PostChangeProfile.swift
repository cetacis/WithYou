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
    let para = [
        "username": UserData.username,
        "bio": UserData.bio,
        "mobile": UserData.mobile,
        "birthday": UserData.birthday,
        "friends": UserData.Friends,
        "age": UserData.age,
        "password": UserData.password,
        "constellation": UserData.constellation,
        "sex": UserData.sex,
        "img_path": UserData.img_path,
        "together_tasks": UserData.TogetherTasks,
        "private_tasks": UserData.PrivateTasks,
        "email": UserData.email,
        "messages": UserData.Messages
    ] as [String : Any]
    var msg = ""
    var code = 0
    let jsonData = try? JSONSerialization.data(withJSONObject: para)
    let session = URLSession(configuration: .default)
    let url = "https://mbp.cetacis.dev/api/ChangeProfile"
    var request = URLRequest(url: URL(string: url)!)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = jsonData
    let task = session.dataTask(with: request) {(data, response, error) in
        do {
            let r = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            code = r.value(forKey: "code") as! Int
            msg = r.value(forKey: "msg") as! String
            completion(code, msg)
        } catch {
            code = 500
            msg = "Connect Server error"
            completion(code, msg)
        }
    }
    task.resume()
}

//
//  PostLogin.swift
//  WithYou
//
//  Created by 邓萌达 on 11/7/20.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation

func PostLogin(email:String, pass:String) -> (Int, String) {
    // semaphore to wait the response task end.
    let semaphore = DispatchSemaphore(value: 0);
    
    let session = URLSession(configuration: .default)
    let url = "https://withyou.cetacis.dev/api/login"
    var request = URLRequest(url: URL(string: url)!)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let postData = ["email":email,"pass":pass]
    let postString = postData.compactMap({ (key, value) -> String in
        return "\(key)=\(value)"
    }).joined(separator: "&")
    var code = 0
    var msg = ""
    request.httpBody = postString.data(using: .utf8)
    let task = session.dataTask(with: request) {(data, response, error) in
        do {
            let r = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            code = r.value(forKey: "code") as! Int
            msg = r.value(forKey: "msg") as! String
            semaphore.signal()
        } catch {
            code = 500
            msg = "Connect Server error"
            semaphore.signal()
        }
    }
    
    task.resume()
    if semaphore.wait(timeout: .now() + 15) == .success {
        return (code, msg)
    } else {
        return (500, "Connection Timed out")
    }
}

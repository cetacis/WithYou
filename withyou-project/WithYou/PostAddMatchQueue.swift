//
//  PostAddMatchQueue.swift
//  WithYou
//
//  Created by 邓萌达 on 16/7/20.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

func PostAddMatchQueue(completion: @escaping (_ code: Int, _ msg: String) -> (), email:String, taskid: Int) {
    let para = TaskQuue(TaskId: taskid, Email: email)
    AF.request("https://withyou.cetacis.dev/api/match",
               method: .post,
               parameters: para
    ).responseJSON { (response) in
        let json = JSON(response.data!)
        let code = json["code"].intValue
        let msg = json["msg"].string!
        completion(code, msg)
    }
}




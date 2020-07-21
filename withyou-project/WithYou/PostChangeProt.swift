//
//  PostChangeProt.swift
//  WithYou
//
//  Created by 邓萌达 on 15/7/20.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

func PostChangeProt(completion: @escaping (_ code: Int, _ msg: String) -> (), email:String, password: String) {
    var code = 100
    var msg = ""
    print(getSize(url: PostImagePath!))
    print(type(of: PostImagePath!))
    AF.upload(multipartFormData: { (MultipartFormData) in
        print(type(of: PostImagePath!))
        MultipartFormData.append(PostImagePath!, withName: "file")
        MultipartFormData.append(email.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "email")
        MultipartFormData.append(password.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "pass")
    }, to: "https://withyou.cetacis.dev/api/upload")
    .responseJSON { (reponse) in
        let json = JSON(reponse.data!)
        code = json["code"].intValue
        msg = json["msg"].string!
        completion(code, msg)
    }
}


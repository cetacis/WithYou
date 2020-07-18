//
//  PostRegister.swift
//  WithYou
//
//  Created by 邓萌达 on 11/7/20.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SSZipArchive

func PostRegister(completion: @escaping (_ code: Int, _ msg: String) -> (), name: String, email:String, password: String) {
    var code = 100
    var msg = ""
    print(getSize(url: PostImagePath!))
    print(type(of: PostImagePath!))
    AF.upload(multipartFormData: { (MultipartFormData) in
        print(type(of: PostImagePath!))
        MultipartFormData.append(PostImagePath!, withName: "file")
        MultipartFormData.append(name.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "name")
        MultipartFormData.append(email.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "email")
        MultipartFormData.append(password.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "pass")
    }, to: "https://withyou.cetacis.dev/api/register")
    .responseJSON { (reponse) in
        let json = JSON(reponse.data!)
        code = json["code"].intValue
        msg = json["msg"].string!
        print(code)
        completion(code, msg)
    }
}

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

func PostRegister(completion: @escaping (_ code: Int, _ msg: String) -> (), name: String, email:String, password: String) {
    var code = 0
    var msg = ""
    AF.upload(multipartFormData: { (MultipartFormData) in
        MultipartFormData.append(PostImagePath!, withName: "file")
        MultipartFormData.append(name.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "name")
        MultipartFormData.append(email.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "email")
        MultipartFormData.append(password.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "pass")
    }, to: "http://127.0.0.1:8080/api/register")
    .responseJSON { (reponse) in
        let json = JSON(reponse.data!)
        code = json["code"].intValue
        msg = json["msg"].string!
        completion(code, msg)
    }
}

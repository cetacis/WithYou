//
//  GetImage.swift
//  WithYou
//
//  Created by 邓萌达 on 18/7/20.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
import SwiftUI

func GetImage(completion: @escaping (_ img: Image) -> (), url: String) {
    AF.download(url).responseData { (response) in
        if let data = response.value {
            let uiimage = UIImage(data: data)
            let image = Image(uiImage: uiimage!)
            completion(image)
        }
    }
}

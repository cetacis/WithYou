//
//  GetFriendsInfo.swift
//  WithYou
//
//  Created by 邓萌达 on 21/7/20.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation

func GetFriends() {
    for FriendEmail in User.Friends {
        GetFriendInfo(completion: { (UserInfo) in
            Friends.append(UserInfo)
            GetImage(completion: { (Image) in
                ImgDict.updateValue(Image, forKey: FriendEmail)
            }, url: "https://withyou.cetacis.dev/api" + UserInfo.img_path)
        }, email: FriendEmail)
    }
}

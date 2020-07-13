//
//  ChangeProfile.swift
//  WithYou
//
//  Created by kelo on 2020/4/15.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

struct ChangeProfile: View {
    @State var image: Image? = Choose
    @State var isshowingNavi = true
    @State var changingBio = User.bio
    @State var changingName = User.username
    @State var changingMobile = User.mobile
    @State var changingAge = User.age
    @State var changingSex = User.sex
    @State var changingBirth = User.birthday
    @State var changingStar = User.constellation
    @State var changingBlood = User.blood
    var body: some View {
        VStack {
            Portrait_change(image: $image)
            Divider()
            NavigationLink(destination: ChangeLinkbio(change_bio: $changingBio)) {
                VStack{
                    HStack {
                        Text("Bio")
                        Spacer()
                    }
                    HStack {
                        Text(changingBio)
                            .font(.headline)
                        Spacer()
                    }
                }.frame(width: 365)
            }
            Divider()
            NavigationLink(destination: ChangeLinkName(change_name: $changingName)) {
                VStack{
                    HStack {
                        Text("Name")
                        Spacer()
                    }
                    HStack {
                        Text(changingName)
                            .font(.headline)
                        Spacer()
                    }
                }.frame(width: 365)
            }
            Divider()
            NavigationLink(destination: ChangeLinkMobile(change_mobile: $changingMobile)) {
                VStack{
                    HStack {
                        Text("Mobile")
                        Spacer()
                    }
                    HStack {
                        Text(changingMobile)
                            .font(.headline)
                        Spacer()
                    }
                }.frame(width: 365)
            }
            Divider()
            NavigationLink(destination: ChangeLinkAge(change_age: $changingAge)) {
                VStack{
                    HStack {
                        Text("Age")
                        Spacer()
                    }
                    HStack {
                        Text(changingAge)
                            .font(.headline)
                        Spacer()
                    }
                }.frame(width: 365)
            }
            VStack{
                Divider()
                NavigationLink(destination: ChangeLinkSex(change_sex: $changingSex)) {
                    VStack{
                        HStack {
                            Text("Sex")
                            Spacer()
                        }
                        HStack {
                            Text(changingSex)
                                .font(.headline)
                            Spacer()
                        }
                    }.frame(width: 365)
                }
                Divider()
                NavigationLink(destination: ChangeLinkBirthDay(change_birthDay: $changingBirth)) {
                    VStack{
                        HStack {
                            Text("Birth")
                            Spacer()
                        }
                        HStack {
                            Text(changingBirth)
                                .font(.headline)
                            Spacer()
                        }
                    }.frame(width: 365)
                }
                Divider()
                NavigationLink(destination: ChangeLinkStar(change_star: $changingStar)) {
                    VStack{
                        HStack {
                            Text("Star")
                            Spacer()
                        }
                        HStack {
                            Text(changingStar)
                                .font(.headline)
                            Spacer()
                        }
                    }.frame(width: 365)
                }
                Divider()
                NavigationLink(destination: ChangeLinkBlood(change_blood: $changingBlood)) {
                    VStack{
                        HStack {
                            Text("Blood")
                            Spacer()
                        }
                        HStack {
                            Text(changingBlood)
                                .font(.headline)
                            Spacer()
                        }
                    }.frame(width: 365)
                }
                Spacer()
            }
        }
    }
}

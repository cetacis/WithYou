//
//  changelink.swift
//  WithYou
//
//  Created by kelo on 2020/4/15.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

func isValidAge(_ Age: String) -> Bool {
    let ageReg = "[1-9]?[0-9]"
    let agePred = NSPredicate(format:"SELF MATCHES %@", ageReg)
    return agePred.evaluate(with: Age)
}

func isValidBio(_ Bio: String) -> Bool {
    return Bio.count > 0
}

func isValidMobile(_ Mobile: String) -> Bool {
    let mobileReg = "[1][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]"
    let mobilePred = NSPredicate(format:"SELF MATCHES %@", mobileReg)
    return mobilePred.evaluate(with: Mobile)
}

func isValidStar(_ Star: String) -> Bool {
    return Star.count > 0
}

func isValidBlood(_ Blood: String) -> Bool {
    return Blood == "A" || Blood == "B" || Blood == "AB" || Blood == "O"
}

func isValidSex(_ Sex:String) -> Bool {
    return Sex == "male" || Sex == "female"
}

func isValidBirthDay(_ Birth: String) -> Bool {
    let birthReg = "[1-2][0-9][0-9][0-9]\\-[0-1][0-9]\\-[0-3]?[0-9]"
    let birthPred = NSPredicate(format:"SELF MATCHES %@", birthReg)
    return birthPred.evaluate(with: Birth)
}

struct ChangeLinkName:View {
    @Binding var change_name: String
    @State var showingAlert = false
    @State var changing = ""
    var body: some View {
        VStack {
            LabelTextField(label: "Name", placeHolder: "name longer than 5", icon: "person.circle.fill", text: $changing).foregroundColor(isValidName(changing) ? .green : .black)
            if (isValidName(changing)) {
                Button("Save"){
                
                    self.change_name = self.changing
                    PostChangeProfile(completion: { (code, msg) in
                                                print(code, msg)
                                            }, UserData: User)
                    self.showingAlert = true
                } .alert(isPresented: $showingAlert) {
                    Alert(title: Text("successfully modified"), dismissButton: .default(Text("OK")))
                } .padding().background(Color.yellow).cornerRadius(100).foregroundColor(.gray).offset(x:20).font(.system(size:15,design:.rounded))
            }
            Spacer()
        }
    }
}

struct ChangeLinkAge:View {
    @Binding var change_age: String
    @State var showingAlert = false
    @State var changing = ""
    var body: some View {
        VStack {
            LabelTextField(label: "Age", placeHolder: "valid age", icon: "a.circle.fill", text: $changing).foregroundColor(isValidAge(changing) ? .green : .black)
            if (isValidAge(changing)) {
                Button("Save"){
                   
                    self.change_age = self.changing
                   PostChangeProfile(completion: { (code, msg) in
                             print(code, msg)
                         }, UserData: User)
                    self.showingAlert = true
                    
                } .alert(isPresented: $showingAlert) {
                    Alert(title: Text("successfully modified"), dismissButton: .default(Text("OK")))
                } .padding().background(Color.yellow).cornerRadius(100).foregroundColor(.gray).offset(x:20).font(.system(size:15,design:.rounded))
            }
            Spacer()
        }
    }
}

struct ChangeLinkbio:View {
    
    @Binding var change_bio: String
    @State var showingAlertBio = false
    @State var changing = ""
    var body: some View {
        VStack {
            LabelTextField(label: "Bio", placeHolder: "valid bio", icon: "b.circle.fill", text: $changing).foregroundColor(isValidBio(changing) ? .green : .black)
            if (isValidBio(changing)) {
                Button("Save"){
                  
                    self.change_bio = self.changing
                    PostChangeProfile(completion: { (code, msg) in
                        print(code, msg)
                    }, UserData: User)
                    self.showingAlertBio = true
                } .alert(isPresented: $showingAlertBio) {
                    Alert(title: Text("successfully modified"), dismissButton: .default(Text("OK")))
                } .padding().background(Color.yellow).cornerRadius(100).foregroundColor(.gray).offset(x:20).font(.system(size:15,design:.rounded))
                
            }
            Spacer()
        }
    }
}

struct ChangeLinkMobile:View {
    @Binding var change_mobile: String
    @State var showingAlert = false
    @State var changing = ""
    var body: some View {
        VStack {
            LabelTextField(label: "Mobile", placeHolder: "valid mobile", icon: "m.circle.fill", text: $changing).foregroundColor(isValidMobile(changing) ? .green : .black)
            if (isValidMobile(changing)) {
                Button("Save"){
                    
                    self.change_mobile = self.changing
                    PostChangeProfile(completion: { (code, msg) in
                        print(code, msg)
                    }, UserData: User)
                    self.showingAlert = true
                } .alert(isPresented: $showingAlert) {
                    Alert(title: Text("successfully modified"), dismissButton: .default(Text("OK")))
                } .padding().background(Color.yellow).cornerRadius(100).foregroundColor(.gray).offset(x:20).font(.system(size:15,design:.rounded))
            }
            Spacer()
        }
    }
}

struct ChangeLinkConstellation:View {
    @Binding var change_star: String
    @State var showingAlert = false
    @State var changing = ""
    var body: some View {
        VStack {
            LabelTextField(label: "Constellation", placeHolder: "valid Constellation", icon: "s.circle.fill", text: $changing).foregroundColor(isValidStar(changing) ? .green : .black)
            if (isValidStar(changing)) {
                Button("Save"){
                   
                    self.change_star = self.changing
                    PostChangeProfile(completion: { (code, msg) in
                        print(code, msg)
                    }, UserData: User)
                    self.showingAlert = true
                } .alert(isPresented: $showingAlert) {
                    Alert(title: Text("successfully modified"), dismissButton: .default(Text("OK")))
                } .padding().background(Color.yellow).cornerRadius(100).foregroundColor(.gray).offset(x:20).font(.system(size:15,design:.rounded))
            }
            Spacer()
        }
    }
}

struct ChangeLinkBirthDay:View {
    @Binding var change_birthDay: String
    @State var showingAlert = false
    @State var changing = ""
    var body: some View {
        VStack {
            LabelTextField(label: "BirthDay", placeHolder: "xxxx-xx-xx", icon: "b.circle.fill", text: $changing).foregroundColor(isValidBirthDay(changing) ? .green : .black)
    
                Button("Save"){
                    
                    self.change_birthDay = self.changing
                    PostChangeProfile(completion: { (code, msg) in
                        print(code, msg)
                    }, UserData: User)
                    self.showingAlert = true
                } .alert(isPresented: $showingAlert) {
                    Alert(title: Text("successfully modified"), dismissButton: .default(Text("OK")))
                } .padding().background(Color.yellow).cornerRadius(100).foregroundColor(.gray).offset(x:20).font(.system(size:15,design:.rounded))
            
            Spacer()
        }
    }
}

struct ChangeLinkSex:View {
    @Binding var change_sex: String
    @State var showingAlert = false
    @State var changing = ""
    var body: some View {
        VStack {
            LabelTextField(label: "Sex", placeHolder: "male/female", icon: "s.circle.fill", text: $changing).foregroundColor(isValidSex(changing) ? .green : .black)
            if (isValidSex(changing)) {
                Button("Save"){
                    self.change_sex = self.changing
                    PostChangeProfile(completion: { (code, msg) in
                                           print(code, msg)
                                       }, UserData: User)
                    self.showingAlert = true
                } .alert(isPresented: $showingAlert) {
                    Alert(title: Text("successfully modified"), dismissButton: .default(Text("OK")))
                } .padding().background(Color.yellow).cornerRadius(100).foregroundColor(.gray).offset(x:20).font(.system(size:15,design:.rounded))
            }
            Spacer()
        }
    }
}

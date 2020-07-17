//
//  login.swift
//  WithYou
//
//  Created by kelo on 2020/4/14.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func prefixedWithIcon(named name: String) -> some View {
        HStack {
            Image(systemName: name)
            self
        }
    }
}
func isValidName(_ name:String)->Bool{
    if(name.count>4){return true}
    else{return false}
}
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}
func isValiddescription(_ description: String) -> Bool {
    if (description.count>0) {
        return true
    }
    else {
        return false
    }
}
func isMatchedPasspord(_ password1:String,_ password2:String)->Bool{
    if (password1 == password2 && password1.count != 0) {
        return true
    }
    else {
        return false
    }
    
}

struct Validation<Value>: ViewModifier {
    var value: Value
    var validator: (Value) -> Bool
    
    func body(content: Content) -> some View {
        // Here we use Group to perform type erasure, to give our
        // method a single return type, as applying the 'border'
        // modifier causes a different type to be returned:
        
        Group {
            if validator(value) {
                content.foregroundColor(Color.blue)
            } else {
                content
            }
        }
    }
}

struct LabelTextField : View {
    var label:String
    var placeHolder: String
    var icon:String
    @Binding var text: String
    var body: some View {
        
        
        VStack(alignment: .leading) {
            Text(label)
            TextField(placeHolder, text: $text)
                .prefixedWithIcon(named: icon)
                .padding(.all)
                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
            
        }
        .padding(.horizontal, 15)
        
    }
}

struct LoginView: View {
    @State private var showingAlertNU = false
    @State private var alertMsg:String = ""
    @State var emailIn = ""
    @State var passpordIn = ""
    @Binding var view_switcher: Int
    var body: some View {
        VStack{
            Text("withYou").offset(y:-100).font(.system(size:60, design: .rounded)).foregroundColor(.blue)
            Text("login")
            
            VStack{
                TextField("email", text: self.$emailIn)
                    .prefixedWithIcon(named: "person.circle.fill")
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(50)
                SecureField("passpord", text: self.$passpordIn)
                    .prefixedWithIcon(named:  "p.circle.fill")
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(50)
            }.offset(y: -110)
             .padding(.horizontal,20)
            HStack{
                Button(action: {
                    self.view_switcher = 0
                },label: { Text("    sign up    ").padding().background(Color.yellow).cornerRadius(100).foregroundColor(Color(red: 215/255, green: 86/255, blue: 33/255)).offset(x:20).font(.system(size:15,design:.rounded)).offset(x:-50) .padding(.horizontal)}
                )
                
                Button("     log in     "){
                    var code:Int
                    var masg:String
                    (code,masg) = PostLogin(email: self.emailIn, pass: self.passpordIn)
                    if code == 0 || code == -1{
                        self.showingAlertNU = true
                        self.alertMsg = masg
                    }else{
                        PostGetUserInfo(completion: {
                            (RtData) in
                            print("The dafault User:\(User)")
                            User = RtData
                            print("The changed User:\(User)")
                            self.view_switcher = 2
                        }, email: self.emailIn, pass: self.passpordIn)
                       
                    }
                }.alert(isPresented: $showingAlertNU) {
                    Alert(title: Text(alertMsg), dismissButton: .default(Text("OK")))
                }
                .padding().background(Color.yellow).cornerRadius(100)
                .foregroundColor(Color(red: 215/255, green: 86/255, blue: 33/255))
                .offset(x:-20).font(.system(size:15,design:.rounded)).offset(x:50).padding(.horizontal)
            }.offset(y: -100)
        }
    }
    
}

struct SignUpView: View {
    @State var email = ""
    @State var name = ""
    @State var description = ""
    @State var password1 = ""
    @State var password2 = ""
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    @State private var showingAlertRP = false
    @State var isalert = false
    @Binding var view_switcher: Int
    @State private var alertMsg: String = ""
    
    var body: some View{
        NavigationView{
            
            
            VStack{
                VStack{
                Text("withYou").offset(y:-90).font(.system(size:60, design: .rounded)).foregroundColor(.blue)
                Text("Register").offset(y:-90).font(.headline)
                }.offset(y:50)
            
                
                VStack{
                    VStack(alignment: .leading) {
                        Text("name")
                        TextField("name longer than 5", text: self.$name)
                            .prefixedWithIcon(named: "person.circle.fill")
                            .padding(.all)
                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                            .cornerRadius(50)
                    }.padding(.horizontal, 15).foregroundColor(isValidName(name) ? .green:.black)
                    VStack(alignment: .leading) {
                        Text("email")
                        TextField("please enter the available", text: self.$email)
                            .prefixedWithIcon(named: "envelope.circle.fill")
                            .padding(.all)
                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                            .cornerRadius(50)
                    }  .padding(.horizontal, 15).foregroundColor(isValidEmail(email) ? .green:.black)
                    
                    
                    
                    VStack(alignment: .leading) {
                        Text("password for the first time")
                        SecureField("password1", text: $password1)
                            .prefixedWithIcon(named: "1.circle.fill")
                            .padding(.all)
                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                            .cornerRadius(50)
                        
                    }
                    .padding(.horizontal, 15).foregroundColor(isMatchedPasspord(password1, password2) ? .green:.black)
                    
                    VStack(alignment: .leading) {
                        Text("password for the second time")
                        SecureField("password2", text: $password2)
                            .prefixedWithIcon(named: "2.circle.fill")
                            .padding(.all)
                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                            .cornerRadius(50)
                        
                    }
                    .padding(.horizontal, 15).foregroundColor(isMatchedPasspord(password1, password2) ? .green:.black)
                    
                    
                    if (name.count>4 && isValidEmail(email)&&isMatchedPasspord(password1, password2)){
                        Button("Submit"){
                            var new_user: UserInfo = UserInfo()
                            new_user.username = self.name
                            new_user.password = self.password1
                            new_user.email = self.email
                        
                            PostRegister(completion: { (code, msg) in
                                self.alertMsg = msg
                                self.isalert = true
                                if code == 0 {
                                    
                                    self.view_switcher = 1
                                }
                            }, name: new_user.username, email: new_user.email, password: new_user.password)
                            
                            }.padding().alert(isPresented: self.$isalert) {
                            Alert(title: Text(self.alertMsg), dismissButton: .default(Text("OK")))
                        }
                        .background(Color.yellow).cornerRadius(100).foregroundColor(.gray).font(.system(size:15,design:.rounded))
                    }
                }
                    .offset(y:-20)
                Portrait().offset(y:-30).padding()
                Button(action: {
                    self.view_switcher = 1
                    print(self.view_switcher)
                },label: { Text("Already have an account? Sign in") }
                ).offset(y:-30)
            }
            
        }
        
    }
    
}



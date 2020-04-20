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
    if (description.count>0){return true}
    else{return false}
}
func isMatchedPasspord(_ password1:String,_ password2:String)->Bool{
    if (password1 == password2 && password1.count != 0) {
        return true
    }
    else {return false}
    
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
    @State var emailIn = ""
    @State var passpordIn = ""
    @Binding var view_switcher: Int
    var body: some View {
        VStack{
            Text("withYou").offset(y:-100).font(.system(size:60, design: .rounded)).foregroundColor(.blue)
            
            VStack{
                TextField("email", text: self.$emailIn)
                    .prefixedWithIcon(named: "person.circle.fill")
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                SecureField("passpord", text: self.$passpordIn)
                    .prefixedWithIcon(named:  "p.circle.fill")
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
            }.offset(y: -110)
                .padding(.horizontal,20)
            HStack{
                Button(action: {
                    self.view_switcher = 0
                },label: { Text("    sign up    ").padding().background(Color.yellow).cornerRadius(100).foregroundColor(Color(red: 215/255, green: 86/255, blue: 33/255)).offset(x:20).font(.system(size:15,design:.rounded)).offset(x:-50) .padding(.horizontal)}
                )
               
                Button("     log in     "){
                        let users = realm.objects(PersonInfo.self).filter("email = '\(self.emailIn)'")
                        if users.count == 0 {
                            self.showingAlertNU = true
                        } else {
                            let enpass = Encrypt_sha256(data:self.passpordIn)
                            if users[0].password == enpass {
                                User = users[0]
                                self.view_switcher = 2
                            } else {
                                print("password wrong")
                                self.showingAlertNU = true
                            }
                        }
                }.alert(isPresented: $showingAlertNU) {
                    Alert(title: Text("Login failed, please check the email and password."), dismissButton: .default(Text("OK")))
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
        
        var body: some View{
            NavigationView{
                
                
                VStack{
                    Text("withYou").offset(y:-90).font(.system(size:60, design: .rounded)).foregroundColor(.blue)
                    Text("Register").offset(y:-90).font(.headline)
                    
                    
                    VStack{
                        
                        
                        LabelTextField(label:"name",placeHolder:"name longer than 5",icon:"person.circle.fill", text: $name).foregroundColor(isValidName(name) ? .green : .black)
                        
                        LabelTextField(label:"emali",placeHolder:"please enter the available",icon: "envelope.circle.fill", text: $email).foregroundColor(isValidEmail(email) ? .green : .black)
                        
                        
                        VStack(alignment: .leading) {
                            Text("password for the first time")
                            SecureField("password1", text: $password1)
                                .prefixedWithIcon(named: "1.circle.fill")
                                .padding(.all)
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                            
                        }
                        .padding(.horizontal, 15).foregroundColor(isMatchedPasspord(password1, password2) ? .green:.black)
                        
                        VStack(alignment: .leading) {
                            Text("password for the second time")
                            SecureField("password2", text: $password2)
                                .prefixedWithIcon(named: "2.circle.fill")
                                .padding(.all)
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                            
                        }
                        .padding(.horizontal, 15).foregroundColor(isMatchedPasspord(password1, password2) ? .green:.black)
                        
                        
                        if (name.count>4 && isValidEmail(email)&&isMatchedPasspord(password1, password2)){
                            Button("Submit"){
                                let admin_email = realm.objects(PersonInfo.self).filter("email = 'Admin@cetacis.dev'")
                                if admin_email.count == 0 {
                                    let new_admin: PersonInfo = PersonInfo()
                                    new_admin.username = "Admin"
                                    new_admin.password = "5f4dcc3b5aa765d61d8327deb882cf99"
                                    new_admin.email = "Admin@cetacis.dev"
                                    try! realm.write {
                                        realm.add(new_admin)
                                    }
                                }
                                let new_user: PersonInfo = PersonInfo()
                                new_user.username = self.name
                                new_user.password = self.password1
                                new_user.email = self.email
                                let users_email = realm.objects(PersonInfo.self).filter("email = '\(self.email)'")
                                var flag = 0
                                if users_email.count != 0 {
                                    self.showingAlertRP = true
                                    flag = 1
                                }
                                if flag == 0 {
                                    User = new_user
                                    User.password = Encrypt_sha256(data: User.password)
                                    try! realm.write {
                                        realm.add(User)
                                    }
                                    self.view_switcher = 1
                                }
                                self.isalert = true
                            }.alert(isPresented: self.$isalert) {
                                Alert(title: self.showingAlertRP ? Text("The Email has being used to register") : Text("Log Succeed"), dismissButton: .default(Text("OK")))
                                }
                            .padding().background(Color.yellow).cornerRadius(100).foregroundColor(.gray).font(.system(size:15,design:.rounded))
                        }
                    }.padding(.horizontal,15)
                        .offset(y:-80)
                    Portrait().offset(y:-30)
                    Button(action: {
                        self.view_switcher = 1
                        print(self.view_switcher)
                    },label: { Text("Already have an account? Sign in") }
                    ).offset(y:-15)
                }
                
            }
            
        }
        
}
    


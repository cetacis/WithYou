//
//  TaskDetail.swift
//  WithYou
//
//  Created by una on 2020/4/16.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import SwiftUI

struct TaskDetail: View {
    @State var comment = ""
    var taskid: Int
    var isFriend: Bool
    @State var isFinished: Bool
    var body: some View {
        VStack{
            
            List{
                Image("exercise").resizable().frame(width:250, height: 400).shadow(radius: 13).overlay(
                    Rectangle().stroke(Color.white, lineWidth: 4)).offset(x:50)
                
                HStack{
                    Text("Task:").fontWeight(.heavy)
                    Text( User.togethertasks[self.taskid].Name)
                    
                }
                HStack{Text("Estamited time: ").fontWeight(.heavy)
                    Text("30 min")}
                if (!isFriend) {
                    Section(header: Text("Completion condition").font(.headline).foregroundColor(isFinished ? .blue:.black)) {
                        Toggle(isOn: $isFinished) { // 5
                            Text("Finish").foregroundColor(isFinished ? .blue:.black)
                        }
                        if (!isFinished) {
                            VStack {
                                Text("comment").font(.system(size: 30)).foregroundColor(Color.gray).multilineTextAlignment(.center).lineLimit(nil).padding(.top,8)
                                TextView(
                                    text: $comment
                                )
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }.frame(height:300)
                                .background(Color(red: 235/255, green: 235/255, blue: 255/255))
                                .cornerRadius(8)
                                .onAppear() {
                                    self.comment = User.togethertasks[self.taskid].comment
                                    try! realm.write {
                                        User.togethertasks[self.taskid].isFinished = self.isFinished
                                        User.togethertasks[self.taskid].comment = self.comment
                                    }
                                }
                        } else {
                            VStack {
                                Text("comment").font(.system(size: 30)).foregroundColor(Color.gray).multilineTextAlignment(.center).lineLimit(nil).padding(.top,8)
                                Text(self.comment).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }.frame(height:300)
                                .background(Color(red: 235/255, green: 235/255, blue: 255/255))
                                .cornerRadius(8)
                                .onAppear() {
                                    try! realm.write {
                                        User.togethertasks[self.taskid].isFinished = self.isFinished
                                        User.togethertasks[self.taskid].comment = self.comment
                                    }
                                    
                            }
                        }
                    }
                } else {
                    VStack {
                        Text("comment").font(.system(size: 30)).foregroundColor(Color.gray).multilineTextAlignment(.center).lineLimit(nil).padding(.top,8)
                        Text(self.comment).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    }.frame(height:300)
                        .background(Color(red: 235/255, green: 235/255, blue: 255/255))
                        .cornerRadius(8)
                }
            }
        }
    }
}


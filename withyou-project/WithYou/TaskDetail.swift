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
                    Text( User.TogetherTasks[self.taskid].name)
                    
                }
                HStack{Text("Estamited time: ").fontWeight(.heavy)
                    Text("30 min")}
                if (!isFriend) {
                    Section(header: Text("Completion condition").font(.headline).foregroundColor(isFinished ? .blue:.black)) {
                        Toggle(isOn: $isFinished) {
                            // 5
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
                                    //print("没完成flag的onappear")
                                    if User.TogetherTasks[self.taskid].IsFinished {
                                        //print("从完成到没完成")
                                        User.TogetherTasks[self.taskid].IsFinished.toggle()
                                        
                                    }else{
                                        //print("一进来就没完成")
                                        
                                        
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
                                    //print("完成flag的onappear")
                                    if User.TogetherTasks[self.taskid].IsFinished {//当完成时进入
                                         //print("一进来就是完成")
                                         self.comment = User.TogetherTasks[self.taskid].comment
                                        print(User.TogetherTasks[self.taskid].comment)
                                    }else{//从没完成到完成
                                       // print("从没完成到完成")
                                        User.TogetherTasks[self.taskid].IsFinished = self.isFinished
                                        User.TogetherTasks[self.taskid].comment = self.comment
                                        PostChangeProfile(completion: {_,_ in }, UserData: User)
                                         print(User.TogetherTasks[self.taskid].comment)
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


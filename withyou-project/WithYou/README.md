// user info
//GetFriendInfo(completion: { (UserInfo) in
//    print(UserInfo)
//}, email: new_user.email)
// the usage of get user info is
//PostGetUserInfo(completion: { (RtData) in
//    User = RtData // the userinfo get from the backend
//    print(User)
//    User.username = "changed!"
//    // change the user's info

   PostChangeProfile(completion: { (code, msg) in
        print(code, msg)
    }, UserData: User)
}, email: new_user.email, pass: new_user.password)

// another example
// the usage of postregister is
// PostRegister(completion: { (code, msg) in
    // print msg
    // or // if code == 0 self.alert = true
    // altert message
    // print code
    // tell user we have registed
// }, name: new_user.username, email: new_user.email, password: new_user.password)
// one exception is postlogin
// (code, msg) = postlogin
// then process code and msg
// this is the test area please do not user
//print(PostGetUserInfo(email: new_user.email, pass: new_user.password))
//test(email: new_user.email, pass: new_user.password)
//print(PostLogin(email: new_user.email, pass: new_user.password))
// test area end.
// post register like this
//print(PostRegister(name: new_user.username, email: new_user.email, password: new_user.password))


func compress(){
    let getImg = UIImage(contentsOfFile:PostImagePath!.path)
    print(getSize(url: PostImagePath!))
    let zipImageData = getImg!.jpegData(compressionQuality: 0.5)
    let PostImagePathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "portrait.jpeg"
    do {
        try zipImageData!.write(to: URL(fileURLWithPath: "/Users/una/1.jpeg"))
    }catch {
    }
    print(PostImagePathString)
    PostImagePath = URL(string: "/Users/una/1.jpeg")
    print(PostImagePath!)
    print(getSize(url: PostImagePath!))
}


<<<<<<< HEAD


如果成功匹配，从后端发消息到前端，前端收到信息。
前端监听怎么完成？

=======
// postChangeprot 


PostChangeProt(completion: { (code, msg) in
    if (code == 0) {
        User.imgpath = msg
    }
}, email: User.email, password: User.password)
>>>>>>> 284be85d6c7f30cdd8295916fbf909da511b5d31

// the psot add match queue and post get match usage is similar
// code and msg are as follows

RtData := RtMsg {
                Msg: "Server Error!",
                Code: 2,
            }
            
            RtData := RtMsg {
                        Msg: "No queue info",
                        Code: 1,
                    }
                    
                    
                    RtData := RtMsg {
                            Msg: "Haven't find out. Plz wait",
                            Code: -1,
                        }
                        
                        
                        RtData := RtMsg {
                                        Msg: result.Email,
                                        Code: 0,
                                    }
                                    // code 0 means success and result.email is the friend's email
                                    
                                    
                                    RtData := RtMsg {
                                            Msg: "add queue success",
                                            Code: 0,
                                        }
                                        // code 0 means success add queue sucess 

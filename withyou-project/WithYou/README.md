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
//    PostChangeProfile(completion: { (code, msg) in
//        print(code, msg)
//    }, UserData: User)
//}, email: new_user.email, pass: new_user.password)
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



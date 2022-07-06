//
//  userModel.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/03.
//

import Foundation

final class UserModel {
    struct User {
        var USERID: String
        var PASSWORD: String
    }
    
    var users: [User] = [
        User(USERID: "Junha0211!", PASSWORD: "Junha85817469!"),
        User(USERID: "Rlaisqls0000", PASSWORD: "Backend123!!!"),
        User(USERID: "Haeun0000", PASSWORD: "Android123!!!")
    ]

//     아이디 형식 검사
    func isValidId(validUserId: String) -> Bool {
        let emailRegEx = "^(.)+$" //1자리 이상
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: validUserId)
    }
    
    // 비밀번호 형식 검사
    func isValidPassword(validPassword: String) -> Bool {
        let passwordRegEx = "^(.)+$" //1자리 이상
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: validPassword)
    }
}

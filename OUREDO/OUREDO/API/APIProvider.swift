//
//  APIProvider.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/01.
//

import Foundation

enum AuthAPI : API {
    
    case lagin
    case signup
    case todo
    
    func path() -> String{
        switch self {
        case.lagin:
            return "/login"//로그인 반환
        case.signup:
            return "/register" //회원가입 반환
        case.todo:
            return "/todo" //todo반환
        }
    }
}

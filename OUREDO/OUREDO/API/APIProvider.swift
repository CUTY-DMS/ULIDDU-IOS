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
    case reissue
    case searchMyPage
    case seeUserId
    case searchUserId
    
    func path() -> String{
        switch self {
//user
        case.lagin:
            return "/login"//로그인 반환
        case.signup:
            return "/register" //회원가입 반환
        case.reissue:
            return "/reissue" // 액세스 토큰 재발급
        case.searchMyPage:
            return "/user" //내 정보 조회
        case.seeUserId:
            return "/user/{id}" //유저 정보 조회
        case.searchUserId:
            return "/search/{userid}" //유저 아이디 검색
//teodo
        
        }
    }
}

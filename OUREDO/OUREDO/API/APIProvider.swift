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
            return "/signin"
        case.signup:
            return "/signin"
        case.todo:
            return "/todo"
        }
    }
}

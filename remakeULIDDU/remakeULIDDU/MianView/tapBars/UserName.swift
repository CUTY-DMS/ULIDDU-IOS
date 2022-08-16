//
//  UserName.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/16.
//

import Foundation

struct UserName : Codable {
    var name : String = .init()
    var userId : String = .init()
    var age : String = .init()
    var task = [Task]()
    
enum CodingKeys: String, CodingKey {
    case name, age
    case userId = "user-Id"
    }
}

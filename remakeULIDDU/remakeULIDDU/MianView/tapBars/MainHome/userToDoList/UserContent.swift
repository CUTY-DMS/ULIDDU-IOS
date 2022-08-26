//
//  UserContent.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/26.
//

import UIKit

struct UserContent: Codable {
    let name : String
    let userID : String
    let age: Int

    enum CodingKeys: String, CodingKey {
        case name
        case userID = "user-id"
        case age
    }
}

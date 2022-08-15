//
//  GetMyToDo.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/15.
//

import Foundation

struct GetMyToDO : Codable {
    var id : String
    var title : String
    var todoData : String //yyyy-mm-dd
    var iscompleted : Bool
    var isliked : Bool
}

//
//  toDoIdDetailVO.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/29.
//

import Foundation

struct ToDoDetail : Codable{
    
    var id : String
    var title : String
    var content : String
    var writer : String
    var toDoDate : String
    var completedDate : String
    var iscompleted : Bool
    var ispublic : Bool
    var likeCount : Int
}

//
//  GetMyToDo.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/15.
//

import Foundation

struct GetToDoList : Codable {
    var id : Int = .init()
    var title : String = .init()
    var todoDate : String = .init()//yyyy-mm-dd
    var iscompleted : Bool = .init()
    var isliked : Bool = .init()
    
    enum CodingKeys : String, CodingKey {
        case id
        case title
        case todoDate = "todo-date"
        case iscompleted
        case isliked
    }
}

struct GetMyList : Codable {
    var id : String
    var title : String
    var todoData : String
    var iscompleted : Bool
    var isliked : Bool
}

struct Task : Codable {
    var image : String = .init()
    var title : String = .init()
    var content : String = .init()
    var done : Bool = .init()
    var ispublic : Bool = .init()
}

//
//  GetMyToDo.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/15.
//

import Foundation

struct GetToDoList : Codable {
    var id : String = .init()
    var title : String = .init()
    var todoData : String = .init()//yyyy-mm-dd
    var iscompleted : Bool = .init()
    var isliked : Bool = .init()
    var task = [Task]()
}

struct GetMyList : Codable {
    var id : String
    var title : String
    var todoData : String
    var iscompleted : Bool
    var isliked : Bool
    var task = [Task]()
}

struct Task : Codable {
    var image : String = .init()
    var title : String = .init()
    var content : String = .init()
    var done : Bool = .init()
    var ispublic : Bool = .init()
}

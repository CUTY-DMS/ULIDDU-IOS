//
//  GetMyToDoList.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/16.
//

import Foundation

struct GetToDoList2 {
    let id : String
    let title : String
    let todoData : String//yyyy-mm-dd
    let iscompleted : Bool
    let isliked : Bool
    let task : [Task]
}

struct GetMyList2 {
    let id : String
    let title : String
    let todoData : String
    let iscompleted : Bool
    let isliked : Bool
    let task : [Task]
}

struct Task2 {
    let image : String
    let title : String
    let content : String
    let done : Bool
    let ispublic : Bool
}

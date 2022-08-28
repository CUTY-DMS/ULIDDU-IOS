//
//  DetilVO.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/28.
//

import UIKit

struct UserDetailTodo : Codable {
    var id : Int
    var title : String
    var content : String
    var writer : String
    var todoDate : String
    var iscompleted : Bool
    var ispublic : Bool
    var isliked : Bool
    var likeCount : Int
    
//    enum CodigKeys : String, CodingKey {
//        case id
//        case title
//        case content
//        case writer
//        case tododate = "todoDate"
//        case iscompleted
//        case isliked
//        case likeCount = "like-count"
//    }
}
//{
//    "id" : "",
//    "title" : "",
//    "content" : "",
//    "writer" : "",
//    "todo-date" : "", //yyyy-MM-dd
//    "completed-date" : "", //yyyy-MM-dd HH:mm:ss (iscompleted가 false면 null)
//    "iscompleted" : (true or false),
//    "ispublic" : (true or false),
//  "isliked" : (true or false),
//    "like-count" :
//}

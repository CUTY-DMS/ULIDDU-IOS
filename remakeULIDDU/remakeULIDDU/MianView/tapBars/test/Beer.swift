//
//  Beer.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/16.
//

import UIKit

struct Beer: Decodable {
    
    let imageURL : String
    let id: String
    let title : String
    let todoDate : String
    let iscompleted : Bool
    let isliked : Bool
    
}

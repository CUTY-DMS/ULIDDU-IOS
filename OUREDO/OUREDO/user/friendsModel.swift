//
//  friendsModel.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/28.
//

struct friendsModel: Codable {
    
    let results: [resultsArr]
    
}

struct resultsArr: Codable {
    
    let name: String
    let userId: String
    let age: String
    
}

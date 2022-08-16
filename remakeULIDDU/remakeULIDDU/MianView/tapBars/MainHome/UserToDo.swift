//
//  UserToDo.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/16.
//
import UIKit

struct Beer: Decodable {
    
    let id : String
    
    var tagLine: String {
        let tags = talineString?.components(separatedBy: ", ")
        let hashtags = tags?.map {
            "#" + $0.replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: " #")
        }
        return hashtags?.joined(separator: " ") ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case talineString = "tagline"
        case imageURL = "image_url"
        case brewersTips = "brewers_tips"
        case foodPairing = "food_pairing"
    }
}

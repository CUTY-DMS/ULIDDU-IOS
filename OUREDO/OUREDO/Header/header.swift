//
//  Header.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/01.
//

import Foundation
import Alamofire
import Security

class Token {
    static let accessToken = "access_token"
    static let refreshToken = "refresh_token"
}

class KeyChain {
    // Create
    class func create(key: String, token: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,   // 저장할 Account
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any   // 저장할 Token
        ]
        SecItemDelete(query)
        // Keychain은 Key값에 중복이 생기면, 저장할 수 없기 때문에 먼저 Delete해줌
        let status = SecItemAdd(query, nil)
        assert(status == noErr, "🥵 failed to save Token")
    }

    // Read
    class func read(key: String) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,  // CFData 타입으로 불러오라는 의미
            kSecMatchLimit: kSecMatchLimitOne       // 중복되는 경우, 하나의 값만 불러오라는 의미
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)

        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            print("🥵 failed to loading, status code = \(status)")
            return nil
        }
    }

    // Delete
    class func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        let status = SecItemDelete(query)
        assert(status == noErr, "🥵 failed to delete the value, status code = \(status)")
    }
}

//
enum Header {
    case accesstoken, tokenIsEmpty, refreshToken
    
    func header() -> HTTPHeaders {
        guard let token = KeyChain.read(key: Token.accessToken) else{
            return ["Content-Type" : "application/json"]
        }
        guard let refreshtoken = KeyChain.read(key: Token.refreshToken) else{
            return ["Content-Type" : "application/json"]
        }
        
        switch self {
        case .accesstoken:
            return HTTPHeaders(["Authorization" : "Bearer " + token, "Content-Type" : "application/json"])
        case .tokenIsEmpty:
            return HTTPHeaders(["Content-Type" : "application/json"])
        case .refreshToken:
            return HTTPHeaders(["Authorization" : "Bearer " + refreshtoken, "Content-Type" : "application/json"])
        }
    }
}

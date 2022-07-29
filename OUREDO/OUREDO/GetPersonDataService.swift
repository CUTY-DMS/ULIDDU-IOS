//
//  GetPersonDataService.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/29.
//

import Foundation
import Alamofire

struct GetPersonDataService {

    static let shared = GetPersonDataService()

    func getPersonInfo(completion : @escaping (friendsModel) -> Void) {
        
        let URL = "https://mocki.io/v1/e5b82f33-832c-43ae-83c8-c3e053a4ead7"
        let header : HTTPHeaders = ["Content-Type": "application/json"]

        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        // 위에서 적어둔 요청설르 가지고 진짜 서버에 보내서 통신 Request를 하는 중
        // 통신이 완료되면 클로저를 통해서 dataRequest라는 이름으로 결과가 도착
        dataRequest.responseData { dataResponse in
            
            // dataResponse가 도착했으니, 그 안에는 통신에 대한 결과물이 있다
            // dataResponse.result는 통신 성공했는지 / 실패했는지 여부
            switch dataResponse.result {
            
            // dataResponse가 성공이면 statusCode와 response(결과데이터)를 guard let 구문을 통해서 저장해 둡니다.
            case .success:
                // dataResponse.statusCode는 Response의 statusCode - 200/400/500
                guard let statusCode = dataResponse.response?.statusCode else {return}
                // dataResponse.value는 Response의 결과 데이터
                guard let value = dataResponse.value else { return }
                
                // judgeStatus라는 함수에 statusCode와 response(결과데이터)를 실어서 보냅니다.
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
             
            // 통신 실패의 경우, completion에 pathErr값을 담아서 뷰컨으로 날려줍니다.
            // 타임아웃 / 통신 불가능의 상태로 통신 자체에 실패한 경우입니다
            case .failure(_):
                print("🚫")
            }
            
        }
    }
    
    // 아까 받은 statusCode를 바탕으로 어떻게 결과값을 처리할 건지 정의합니다.
    private func judgeStatus(by statusCode: Int, _ data: Data) -> friendsModel<Any> {
        
        switch statusCode {
        case 200: return isValidData(data: data) // 성공 -> 데이터를 가공해서 전달해줘야 하기 때문에 isValidData라는 함수로 데이터 넘격줌
        case 400: return .pathErr // -> 요청이 잘못됨
        case 500: return .serverErr // -> 서버 에러
        default: return .networkFail // -> 네트워크 에러로 분기 처리할 예정
            
        }
    }
    
    // 200대로 떨어졌을 때 데이터를 가공하기 위한 함수
    private func isValidData(data: Data) -> friendsModel {
        
        // JSON 데이터를 해독하기 위해 JSONDecoder()를 하나 선언
        let decoder = JSONDecoder()
        
        // data를 우리가 만들어둔 PersonDataModel 형으로 decode 해준다.
        // 실패하면 pathErr로 빼고, 성공하면 decodedData에 값을 뺍니다.
        guard let decodedData = try? decoder.decode(friendsModel.self, from: data) else { return nil }
        
        // 성공적으로 decode를 마치면 success에다가 data 부분을 담아서 completion을 호출합니다.
        return .success(decodedData.data)
    }
}

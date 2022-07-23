//
//  SignUpDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Foundation
import Alamofire

class PwFindDataManager{
    
    func pwFindDataManager(_ viewController: PwFindViewController, _ parameter: PwFindInput){
        
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        AF.request("http://todoary.com:9000/users/password", method: .patch, parameters: parameter, encoder: JSONParameterEncoder.default, headers: headers).validate().responseDecodable(of: PwFindModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess {
                    if result.code == 1000{
                        print("프로필수정성공")
                    }else{
                        print(result.message)
                    }
                }else {
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

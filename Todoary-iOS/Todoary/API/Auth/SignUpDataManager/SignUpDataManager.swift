//
//  SignUpDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Foundation
import Alamofire

class SignUpDataManager{
    
    func posts(_ viewController: SignUpViewController, email: String){
        AF.request("http://todoary.com:9000/auth/email/duplication", method: .get, parameters: ["email":email], encoding: URLEncoding.queryString).validate().responseDecodable(of: SingUpModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess{
                    print("success??")
                    viewController.checkEmailApiResultCode(result.code)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func posts(_ viewController: SignUpViewController, _ parameter: SignUpInput){
        AF.request("http://todoary.com:9000/auth/signup", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: SingUpModel.self) { response in
            switch response.result {
            case .success(let result):
                print("성공")
                viewController.checkSignUpResultCode(result.code)
            case .failure(let error):
                print("실패")
                print(error.localizedDescription)
            }
        }
    }
}

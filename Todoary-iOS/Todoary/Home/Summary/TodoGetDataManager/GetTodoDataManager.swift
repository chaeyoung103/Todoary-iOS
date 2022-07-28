//
//  TodoGetDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation
import Alamofire

class GetTodoDataManager{
    
    func gets(_ viewController: SignUpViewController, email: String){
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
}

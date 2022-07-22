//
//  AutoLoginDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Alamofire

class AutoLoginDataManager {
    func auto(_ veiwController : LoginViewController,
              _ parameter : AutoLoginInput) {
        
        //통신
        AF.request("http://todoary.com:9000/auth/signin/auto",
                   method: .post, parameters: parameter,
                   encoder: JSONParameterEncoder.default, headers: nil)
            .validate()
            .responseDecodable(of: AutoLoginModel.self) {response in
            switch response.result {
            case .success(let result) :
                print("DEBUG: ", result)

            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}
    


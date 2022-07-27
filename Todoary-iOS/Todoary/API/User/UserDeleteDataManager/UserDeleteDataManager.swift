//
//  UserDeleteDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Foundation
import Alamofire

class UserDeleteDataManager{

    func patch(_ viewController: AccountViewController){
        
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        AF.request("http://todoary.com:9000/users/status", method: .patch, parameters: [:], headers: headers).validate().responseDecodable(of: UserDeleteModel.self) { response in
            switch response.result {
            case .success(let result):
                viewController.deleteApiResultCode(result.code)
                return
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

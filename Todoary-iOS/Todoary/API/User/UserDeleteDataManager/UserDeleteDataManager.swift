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
        
        AF.request("https://todoary.com/users/status", method: .patch, parameters: [:], headers: headers).validate().responseDecodable(of: UserDeleteModel.self) { response in
            switch response.result {
            case .success(let result):
                print("계정삭제성공")
                viewController.deleteApiResultCode(result.code)
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                return
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

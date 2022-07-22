//
//  SignoutDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire

class SignoutDataManager {
  
        
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        //통신
    func signout(_ veiwController : AccountViewController) {AF.request("http://todoary.com:9000/auth/users/signout", method: .patch, parameters: [:], headers: self.headers).validate().responseDecodable(of: SignoutModel.self) {response in
            switch response.result {
            case .success(let result) :
                print("DEBUG: ", result)
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}

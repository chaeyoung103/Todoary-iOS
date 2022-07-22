//
//  ProfileDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire

class ProfileDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func profileDataManager( _ viewController : ProfileViewController , _ parameter: ProfileInput) {
        AF.request("http://todoary.com:9000/users/profile", method: .patch, parameters: parameter,  encoder: JSONParameterEncoder.default , headers: headers).validate().responseDecodable(of: ProfileModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess {
                    print("프로필수정성공")
                }else {
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//
//  ProfileImgDeleteDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire

class ProfileImgDeleteDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    //통신
    func profileImgDelete(__ veiwController : ProfileViewController,
                          _ parameter : ProfileImgInput) {
        AF.request("http://todoary.com/users/profile-img", method: .delete, parameters: parameter, encoder: JSONParameterEncoder.default, headers: headers).validate().responseDecodable(of: ProfileImgDeleteModel.self)
        {responce in
//            switch responce.result {
//            case .success(let result) :
//                switch result.code {
//                case 1000 :
//
                }
            }
        }
//    }
//}

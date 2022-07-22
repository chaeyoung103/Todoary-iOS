//
//  GetProfileDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire
import Foundation
class GetProfileDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func getProfileDataManger( _ viewController : ProfileViewController) {
        AF.request("http://todoary.com:9000/users", method: .get, parameters: nil, headers: headers).validate().responseDecodable(of: GetProfileModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess {
                    viewController.successAPI(result.result!)
                    print("프로필조회성공")
                }else {
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

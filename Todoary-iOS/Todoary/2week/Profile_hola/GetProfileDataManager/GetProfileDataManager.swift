//
//  GetProfileDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire

class GetProfileDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func getProfileDataManger( _ viewController : ProfileViewController) {
        AF.request("http://todoary.com:9000/users", method: .get, parameters: nil, headers: headers).validate().responseDecodable(of: GetProfileModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess {
                    
                    switch result.code{
                    case 1000:
                        viewController.successAPI_profile(result.result!)
                        print("프로필조회성공 프로필")
                    default:
                        print(result.message )
                    }
                }else {
                    print(result.message )
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getProfileHomeDataManger( _ viewController : HomeViewController) {
        AF.request("http://todoary.com:9000/users", method: .get, parameters: nil, headers: headers).validate().responseDecodable(of: GetProfileModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess {
                    
                    switch result.code{
                    case 1000:
                        viewController.successAPI_home(result.result!)
                        print("프로필조회성공 홈")
                    default:
                        print(result.message )
                    }
                }else {
                    print(result.message )
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getProfileAccountDataManger( _ viewController : AccountViewController) {
        AF.request("http://todoary.com:9000/users", method: .get, parameters: nil, headers: headers).validate().responseDecodable(of: GetProfileModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess {
                    
                    switch result.code{
                    case 1000:
                        viewController.successAPI_account(result.result!)
                        print("프로필조회성공 홈")
                    default:
                        print(result.message )
                    }
                }else {
                    print(result.message )
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

//
//  GetProfileDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire

class GetProfileDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func getProfileDataManger( _ viewController : UIViewController) {
        AF.request("http://todoary.com:9000/users", method: .get, parameters: nil, headers: headers).validate().responseDecodable(of: GetProfileModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess {
                    
                    switch result.code{
                    case 1000:
                        guard let profile_vc = viewController as? ProfileViewController else{
                            return
                        }
                        profile_vc.successAPI(result.result!)
                        
                        guard let home_vc = viewController as? HomeViewController else{
                            return
                        }
                        print("프로필조회성공")
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

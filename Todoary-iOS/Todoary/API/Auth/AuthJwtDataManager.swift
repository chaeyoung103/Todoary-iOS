//
//  AuthJwtDataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/26.
//

import Alamofire

class AuthJwtDataManager{
    
    func authJwtDataManager( _ parameter: AuthJwtInput){
        AF.request("https://todoary.com/auth/jwt", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil, interceptor: Interceptor()).validate().responseDecodable(of: AuthJwtModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code{
                case 1000:
                    UserDefaults.standard.set(result.result?.token?.accessToken, forKey: "accessToken")
                    UserDefaults.standard.set(result.result?.token?.refreshToken, forKey: "refreshToken")
                    print("토큰재발급 성공")
                    AppDelegate.authJwt = true
                    
//                    if UserDefaults.standard.bool(forKey: "appPasswordCheck") == true {
//                        let appPasswordViewController = AppPasswordViewController()
//                        viewController.navigationController?.pushViewController(appPasswordViewController, animated: true)
//                        viewController.navigationController?.isNavigationBarHidden = true
//                    }else {
//                        let homeViewController = HomeViewController()
//                        viewController.navigationController?.pushViewController(homeViewController, animated: true)
//                        viewController.navigationController?.isNavigationBarHidden = true
//                    }
                default:
                    print("데이터베이스에러")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

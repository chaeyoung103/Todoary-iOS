//
//  AuthJwtDataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/26.
//

import Alamofire

class AuthJwtDataManager{
    
    func authJwtDataManager(_ viewController: LoginViewController, _ parameter: AuthJwtInput){
        AF.request("http://todoary.com:9000/auth/jwt", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: AuthJwtModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code{
                case 1000:
                    UserDefaults.standard.set(result.result?.token?.accessToken, forKey: "accessToken")
                    UserDefaults.standard.set(result.result?.token?.refreshToken, forKey: "refreshToken")
                    
                    print("토큰재발급 성공")
                    let homeViewController = HomeViewController()
                    viewController.navigationController?.pushViewController(homeViewController, animated: true)
                    viewController.navigationController?.isNavigationBarHidden = true
                case 4000:
                    let alert = DataBaseErrorAlert()
                    viewController.present(alert, animated: true, completion: nil)
                default:
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

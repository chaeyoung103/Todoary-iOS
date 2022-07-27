//
//  LoginDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Alamofire

class LoginDataManager{
    
    func loginDataManager(_ viewController : LoginViewController, _ parameter: LoginInput){
        AF.request("https://todoary.com/auth/signin", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil, interceptor: Interceptor()).validate().responseDecodable(of: LoginModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code{
                case 1000:
                    UserDefaults.standard.set(result.result?.token?.accessToken, forKey: "accessToken")
                    print("로그인 성공")
                    
                    let homeViewController = HomeViewController()
                    viewController.navigationController?.pushViewController(homeViewController, animated: true)
                    viewController.navigationController?.isNavigationBarHidden = true
                case 2005:
                    print(result.message)
                case 2011:
                    print(result.message)
                default:
                    let alert = DataBaseErrorAlert()
                    viewController.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

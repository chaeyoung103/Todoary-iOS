//
//  AppleLoginDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/22.
//

import Foundation
import Alamofire

class AppleLoginDataManager{
    
    func get(_ viewController: LoginViewController){
        
        let url = "https://appleid.apple.com/auth/authorize?client_id=com.todoary.ms.services&redirect_uri=https://todoary.com/auth/apple/redirect&response_type=code id_token&scope=name email&response_mode=form_post"
        
        guard let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{ return }
        
            AF.request(encoded, method: .get, parameters: nil).validate().responseDecodable(of: AppleLoginModel.self) { response in
                
                switch response.result {
                case .success(let result):
                    
                    switch result.code{
                    case 1000:
                        print("성공")
                        viewController.navigationController?.pushViewController(AgreementViewController(), animated: true)
                    default:
                        print(result.message)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    
//        func post(_ viewController : LoginViewController, _ parameter: AppleLoginInput){
//            AF.request("https://todoary.com/auth/signup/oauth2", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil, interceptor: Interceptor()).validate().responseDecodable(of: ApiModel.self) { response in
//                switch response.result {
//                case .success(let result):
//                    switch result.code{
//                    case 1000:
//                        UserDefaults.standard.set(result.result?.token?.accessToken, forKey: "accessToken")
//                        print("로그인 성공")
//                        if UserDefaults.standard.bool(forKey: "appPasswordCheck") == true {
//                            let appPasswordViewController = AppPasswordViewController()
//                            viewController.navigationController?.pushViewController(appPasswordViewController, animated: true)
//                            viewController.navigationController?.isNavigationBarHidden = true
//                        }else {
//                            let homeViewController = HomeViewController()
//                            viewController.navigationController?.pushViewController(homeViewController, animated: true)
//                            viewController.navigationController?.isNavigationBarHidden = true
//                        }
//
//                    case 2005:
//                        print(result.message)
//                    case 2011:
//                        let alert = UIAlertController(title: "회원정보가 존재하지 않습니다.", message: nil, preferredStyle: .alert)
//                        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
//                        alert.addAction(action)
//                        viewController.present(alert, animated: true, completion: nil)
//                    case 2112:
//                        let alert = UIAlertController(title: "로그인 정보가 일치하지 않습니다.", message: nil, preferredStyle: .alert)
//                        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
//                        alert.addAction(action)
//                        viewController.present(alert, animated: true, completion: nil)
//                    default:
//                        let alert = DataBaseErrorAlert()
//                        viewController.present(alert, animated: true, completion: nil)
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }

}

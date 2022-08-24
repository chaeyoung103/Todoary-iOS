//
//  AppleLoginDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/22.
//

import Foundation
import Alamofire

class AppleLoginDataManager{
    
    func post(_ viewController: LoginViewController, parameter: AppleLoginInput){
        
            AF.request("https://todoary.com/auth/apple/token", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: AppleLoginModel.self) { response in
                
                switch response.result {
                case .success(let result):
                    
                    switch result.code{
                    case 1000:
                        print("성공")
                    default:
                        print(result.message)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    
    func post(_ viewController: AgreementViewController, parameter: AppleLoginInput, userIdentifier: String){
        
            AF.request("https://todoary.com/auth/apple/token", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: AppleLoginModel.self) { response in
                
                switch response.result {
                case .success(let result):
                    switch result.code{
                    case 1000:
                        print("성공")
                        KeyChain.create(key: Const.UserDefaults.appleIdentifier, value: userIdentifier)
                        viewController.navigationController?.pushViewController(HomeViewController(), animated: true)
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

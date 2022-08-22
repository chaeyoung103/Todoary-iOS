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

}

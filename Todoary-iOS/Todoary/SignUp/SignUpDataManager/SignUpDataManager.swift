//
//  SignUpDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Foundation
import Alamofire

class SignUpDataManager{
    
//    _ viewController: SignUpViewController,
    func posts(_ viewController: SignUpViewController, email: SignUpInput){
        AF.request("http://todoary.com:9000/auth/signup", method: .post, parameters: email, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: SingUpModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess{
                    viewController.checkApiResultCode(result.code)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func posts(_ viewController: SignUpViewController, _ parameter: SignUpInput){
        AF.request("http://todoary.com:9000/auth/signup", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: SingUpModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess{
                    print("성공")
                    viewController.navigationController?.pushViewController(AgreementViewController(), animated: true)
                }else{
                    print(result.messsage)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//
//  SignUpDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Foundation
import Alamofire

class PwFindDataManager{
    
    func patch(_ viewController: PwFindViewController, _ parameter: PwFindInput){
        
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        AF.request("http://todoary.com:9000/users/password", method: .patch, parameters: parameter, encoder: JSONParameterEncoder.default, headers: headers).validate().responseDecodable(of: PwFindModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess && result.code == 1000{
                    print("성공")
                    viewController.navigationController?.popViewController(animated: true)
//                    viewController.navigationController?.pushViewController(AgreementViewController(), animated: true)
                }else{
                    print(result.messsage)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

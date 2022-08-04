//
//  TodoSettingDataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/27.
//

import Alamofire

class TodoSettingDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func todoSettingDataManager( _ viewController : TodoSettingViewController , _ parameter: TodoSettingInput) {
        AF.request("https://todoary.com/todo", method: .post, parameters: parameter,  encoder: JSONParameterEncoder.default , headers: headers).validate().responseDecodable(of: TodoSettingModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    print("투두생성성공")
                    parameter.targetDate
                    viewController.navigationController?.popViewController(animated: true)
                case 2201:
                    print("중복된 닉네임입니다")
                default:
                    print(result.message)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


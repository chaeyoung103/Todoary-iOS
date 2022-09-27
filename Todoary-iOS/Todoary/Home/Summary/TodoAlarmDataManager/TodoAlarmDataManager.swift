//
//  TodoAlarmDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/27.
//

import Foundation
import Alamofire

class TodoAlarmDataManager{
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func patch(parameter: TodoSettingInput, todoId: Int){
    
        AF.request("https://todoary.com/todo/\(todoId)/alarm",
                   method: .patch,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .validate().responseDecodable(of: ApiModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("alarm patch success")
//                    HomeViewController.bottomSheetVC.checkSendPinApiResultCode(result.code, indexPath)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}

//
//  TodoPinDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/30.
//

import UIKit
import Alamofire

class TodoPinDataManager {

    func patch(cell: TodoListTableViewCell, parameter: TodoPinInput){
        
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        AF.request("https://todoary.com/todo/pin",
                   method: .patch,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .validate().responseDecodable(of: ApiModel.self) { response in
                switch response.result {
                case .success(let result):
                    cell.checkSendCheckboxApiResultCode(result.code)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}

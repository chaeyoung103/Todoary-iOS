//
//  TodoGetByCategoryDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation

class TodoGetByCategoryDataManager{
    func get(cell: TodoListTableViewCell, parameter: TodoCheckboxInput){
        
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        AF.request("https://todoary.com/todo/check",
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

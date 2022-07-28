//
//  TodoDeleteDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation
import Alamofire

class TodoDeleteDataManager{

    func delete(_ cell: TodoListTableViewCell, todoId: Int){
        
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        AF.request("http://todoary.com/todo/:\(todoId)", method: .delete, parameters: [:], headers: headers).validate().responseDecodable(of: UserDeleteModel.self) { response in
            switch response.result {
            case .success(let result):
                cell.deleteApiResultCode()
                return
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

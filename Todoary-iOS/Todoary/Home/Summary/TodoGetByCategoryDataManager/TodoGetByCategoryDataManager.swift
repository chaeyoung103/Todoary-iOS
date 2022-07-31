//
//  TodoGetByCategoryDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation
import Alamofire

class TodoGetByCategoryDataManager{
    
    func get(categoryId: Int){
        
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        AF.request("https://todoary.com/todo/caregory/\(categoryId)",
                   method: .get,
                   parameters: nil,
                   headers: headers)
            .validate().responseDecodable(of: GetTodoModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("성공")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}

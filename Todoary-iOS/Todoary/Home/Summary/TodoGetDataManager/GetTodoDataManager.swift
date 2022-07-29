//
//  TodoGetDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation
import Alamofire

class GetTodoDataManager{
    
    func gets(_ date: String){
        AF.request("http://todoary.com/todo", method: .get, parameters: ["date":date], encoding: URLEncoding.queryString).validate().responseDecodable(of: GetTodoModel.self) { response in
            switch response.result {
            case .success(let result):
                HomeViewController.bottomSheetVC.checkApiResultCode(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ConvertDate{
    
    var year: Int?
    var month: Int?
    var date: String?
    
    func dateSendToServerType() -> String{
    
        let monthString = self.month! < 10 ? "0\(month!)" : "\(month!)"
        
        let dateString = self.date!.count < 2 ? "0\(date!)" : date!
        
        return "\(year!)-\(monthString)-\(dateString)"
    }
    
    func dateUseAtFrontType() -> String{
        
        return ""
    }
}

//
//  AlarmTodoDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Foundation
import Alamofire

enum AlarmType{
    case Todoary
    case Diary
    case Remind
}

class AlarmDataManager {
    
    func patch(cell: AlarmSettingTableViewCell, isChecked: Bool, alarmType: AlarmType){
        
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        var url : String{
            switch alarmType {
            case .Todoary:
                return "users/alarm/todo"
            case .Diary:
                return "users/alarm/diary"
            case .Remind:
                return "users/alarm/remind"
            }
        }
        
        AF.request("https://todoary.com/\(url)",
                   method: .patch,
                   parameters: ["isChecked":isChecked],
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .validate().responseDecodable(of: ApiModel.self) { response in
                switch response.result {
                case .success(let result):
                    cell.checkAlarmApiResultCode(result.code)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}

//
//  AlarmTodoDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Foundation
import Alamofire


class AlarmDataManager {
    
    func patch(cell: AlarmSettingTableViewCell, isChecked: Bool){
        
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        AF.request("https://todoary.com/users/alarm/todo",
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
